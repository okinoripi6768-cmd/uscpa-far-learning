import { supabase } from './supabase';
import type { DailyTask, TaskResult } from './types';

export async function getTodaysTasks(): Promise<DailyTask[]> {
  await checkAndAdjustTaskLimit();

  const settings = await getUserSettings();
  if (!settings) return [];

  const today = new Date().toISOString().split('T')[0];
  const currentRound = settings.current_round;

  const { data: tasksWithProgress, error } = await supabase
    .from('tasks')
    .select(`
      *,
      progress:task_progress(*),
      chapter:chapters(*),
      lecture:lectures(*)
    `)
    .lte('round_unlock', currentRound)
    .order('order_index');

  if (error || !tasksWithProgress) {
    console.error('Error fetching tasks:', error);
    return [];
  }

  const excludedChapters = (settings.excluded_chapters as string[]) || [];
  const neverCompletedTasks: DailyTask[] = [];
  const reviewTasks: DailyTask[] = [];
  const newTasks: DailyTask[] = [];

  for (const task of tasksWithProgress) {
    const progress = Array.isArray(task.progress)
      ? task.progress.find(p => p.current_round === currentRound)
      : null;

    const chapter = Array.isArray(task.chapter) ? task.chapter[0] : task.chapter;
    const lecture = Array.isArray(task.lecture) ? task.lecture[0] : task.lecture;

    if (!chapter) continue;
    if (excludedChapters.includes(chapter.id)) continue;

    const shouldIncludeTaskType = shouldIncludeTask(task.task_type, currentRound);
    if (!shouldIncludeTaskType) continue;

    const hasNeverBeenCompleted = !progress?.last_completed_at;
    const isPriority = progress?.next_review_date
      ? progress.next_review_date <= today
      : false;

    const dailyTask: DailyTask = {
      task,
      progress: progress || {
        id: '',
        task_id: task.id,
        current_round: currentRound,
        status: 'pending',
        last_result: null,
        last_completed_at: null,
        next_review_date: null,
        attempt_count: 0,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
      },
      chapter,
      lecture: lecture || undefined,
      isPriority,
    };

    if (hasNeverBeenCompleted) {
      neverCompletedTasks.push(dailyTask);
    } else if (isPriority) {
      reviewTasks.push(dailyTask);
    } else if (progress?.status === 'active') {
      newTasks.push(dailyTask);
    }
  }

  const combinedTasks = [...neverCompletedTasks, ...reviewTasks, ...newTasks];
  const selectedTasks = await selectTasksForRound(combinedTasks, currentRound, settings.daily_task_limit);

  return selectedTasks;
}

function shouldIncludeTask(taskType: string, round: number): boolean {
  if (round === 1) {
    return true;
  } else if (round === 2 || round === 3) {
    return taskType === 'mc';
  } else if (round >= 4) {
    return taskType === 'mc' || taskType === 'tbs';
  }
  return true;
}

async function selectTasksForRound(tasks: DailyTask[], round: number, limit: number): Promise<DailyTask[]> {
  if (round === 1) {
    return selectRound1Tasks(tasks, limit);
  } else {
    return await selectRound2PlusTasks(tasks, limit);
  }
}

function selectRound1Tasks(tasks: DailyTask[], limit: number): DailyTask[] {
  const result: DailyTask[] = [];

  const lectureGroups = new Map<string, DailyTask[]>();
  for (const task of tasks) {
    const lectureId = task.task.lecture_id || task.lecture?.id || 'no-lecture';
    if (!lectureGroups.has(lectureId)) {
      lectureGroups.set(lectureId, []);
    }
    lectureGroups.get(lectureId)!.push(task);
  }

  const processedLectures = new Set<string>();

  for (const task of tasks) {
    if (result.length >= limit) break;

    const lectureId = task.task.lecture_id || task.lecture?.id || 'no-lecture';
    if (processedLectures.has(lectureId)) continue;

    const group = lectureGroups.get(lectureId) || [];
    const lecture = group.find(t => t.task.task_type === 'lecture');

    if (!lecture) {
      const incompleteTasks = group.filter(
        t => (!t.progress.last_completed_at || t.isPriority)
      );

      if (incompleteTasks.length > 0) {
        for (const incompleteTask of incompleteTasks) {
          if (result.length >= limit) break;
          result.push(incompleteTask);
        }
        processedLectures.add(lectureId);
        break;
      }
      processedLectures.add(lectureId);
      continue;
    }

    const lectureCompleted = lecture.progress.last_completed_at !== null;

    if (!lectureCompleted) {
      result.push(lecture);
      processedLectures.add(lectureId);
      break;
    } else {
      const incompleteTasks = group.filter(
        t => t.task.task_type !== 'lecture' &&
             (!t.progress.last_completed_at || t.isPriority)
      );

      if (incompleteTasks.length > 0) {
        for (const incompleteTask of incompleteTasks) {
          if (result.length >= limit) break;
          result.push(incompleteTask);
        }
        processedLectures.add(lectureId);
        break;
      } else {
        processedLectures.add(lectureId);
      }
    }
  }

  return result;
}

async function selectRound2PlusTasks(tasks: DailyTask[], limit: number): Promise<DailyTask[]> {
  const neverCompletedTasks = tasks.filter(t => !t.progress.last_completed_at);
  const priorityTasks = tasks.filter(t => t.progress.last_completed_at && t.isPriority);
  const otherTasks = tasks.filter(t => t.progress.last_completed_at && !t.isPriority);

  const selected: DailyTask[] = [];

  const minNewTasks = Math.ceil(limit * 0.6);
  const maxReviewTasks = Math.floor(limit * 0.4);

  for (const task of neverCompletedTasks) {
    if (selected.length >= minNewTasks) break;
    selected.push(task);
  }

  for (const task of priorityTasks) {
    if (selected.length >= limit) break;
    const currentReviewCount = selected.filter(t => t.isPriority).length;
    if (currentReviewCount >= maxReviewTasks) break;
    selected.push(task);
  }

  if (selected.length < limit) {
    for (const task of neverCompletedTasks) {
      if (selected.some(s => s.task.id === task.task.id)) continue;
      if (selected.length >= limit) break;
      selected.push(task);
    }
  }

  if (selected.length < limit) {
    for (const task of otherTasks) {
      if (selected.length >= limit) break;
      selected.push(task);
    }
  }

  return selected;
}

export async function getUserSettings() {
  const { data, error } = await supabase
    .from('user_settings')
    .select('*')
    .maybeSingle();

  if (error) {
    console.error('Error fetching settings:', error);
    return null;
  }

  return data;
}

export async function getAllChapters() {
  const { data, error } = await supabase
    .from('chapters')
    .select('*')
    .order('order_index');

  if (error) {
    console.error('Error fetching chapters:', error);
    return [];
  }

  return data || [];
}

export async function completeTask(
  taskId: string,
  result: TaskResult | null,
  currentRound: number,
  notes?: string
) {
  const today = new Date().toISOString();
  const todayDate = today.split('T')[0];

  let nextReviewDate: string | null = null;
  if (result === 'correct') {
    const reviewDate = new Date();
    reviewDate.setDate(reviewDate.getDate() + 15);
    nextReviewDate = reviewDate.toISOString().split('T')[0];
  } else if (result === 'incorrect') {
    const reviewDate = new Date();
    reviewDate.setDate(reviewDate.getDate() + 5);
    nextReviewDate = reviewDate.toISOString().split('T')[0];
  }

  const { data: existingProgress } = await supabase
    .from('task_progress')
    .select('*')
    .eq('task_id', taskId)
    .eq('current_round', currentRound)
    .maybeSingle();

  if (existingProgress) {
    const { error } = await supabase
      .from('task_progress')
      .update({
        status: 'completed',
        last_result: result,
        last_completed_at: today,
        next_review_date: nextReviewDate,
        attempt_count: existingProgress.attempt_count + 1,
        notes: notes || existingProgress.notes,
        updated_at: today,
      })
      .eq('id', existingProgress.id);

    if (error) {
      console.error('Error updating progress:', error);
      throw error;
    }
  } else {
    const { error } = await supabase
      .from('task_progress')
      .insert({
        task_id: taskId,
        current_round: currentRound,
        status: 'completed',
        last_result: result,
        last_completed_at: today,
        next_review_date: nextReviewDate,
        attempt_count: 1,
        notes: notes || null,
        created_at: today,
        updated_at: today,
      });

    if (error) {
      console.error('Error creating progress:', error);
      throw error;
    }
  }
}

export async function updateUserSettings(updates: {
  current_round?: number;
  daily_task_limit?: number;
  original_daily_task_limit?: number;
  excluded_chapters?: string[];
}) {
  const { data: settings } = await supabase
    .from('user_settings')
    .select('*')
    .maybeSingle();

  if (!settings) return;

  const updateData: Record<string, unknown> = {
    ...updates,
    updated_at: new Date().toISOString(),
  };

  if (updates.daily_task_limit && !updates.original_daily_task_limit) {
    updateData.original_daily_task_limit = updates.daily_task_limit;
  }

  const { error } = await supabase
    .from('user_settings')
    .update(updateData)
    .eq('id', settings.id);

  if (error) {
    console.error('Error updating settings:', error);
    throw error;
  }
}

export async function resetProgress() {
  const { error } = await supabase
    .from('task_progress')
    .delete()
    .neq('id', '00000000-0000-0000-0000-000000000000');

  if (error) {
    console.error('Error resetting progress:', error);
    throw error;
  }

  const { data: settings } = await supabase
    .from('user_settings')
    .select('*')
    .maybeSingle();

  if (settings) {
    await supabase
      .from('user_settings')
      .update({
        current_round: 1,
        daily_task_limit: settings.original_daily_task_limit || 5,
        consecutive_completion_days: 0,
        last_completion_check_date: null,
        updated_at: new Date().toISOString(),
      })
      .eq('id', settings.id);
  }
}

export async function checkAndAdjustTaskLimit() {
  const settings = await getUserSettings();
  if (!settings) return;

  const today = new Date().toISOString().split('T')[0];
  const yesterday = new Date();
  yesterday.setDate(yesterday.getDate() - 1);
  const yesterdayDate = yesterday.toISOString().split('T')[0];

  if (settings.last_completion_check_date === today) {
    return;
  }

  const { data: yesterdayProgress } = await supabase
    .from('task_progress')
    .select('*')
    .eq('current_round', settings.current_round)
    .gte('last_completed_at', `${yesterdayDate}T00:00:00`)
    .lt('last_completed_at', `${today}T00:00:00`);

  const completedCount = yesterdayProgress?.length || 0;
  const expectedCount = settings.daily_task_limit;

  let newLimit = settings.daily_task_limit;
  let consecutiveDays = settings.consecutive_completion_days;

  if (completedCount < expectedCount && completedCount > 0) {
    newLimit = Math.max(1, Math.min(completedCount, settings.daily_task_limit - 1));
    consecutiveDays = 0;
  } else if (completedCount >= expectedCount) {
    consecutiveDays += 1;
    if (consecutiveDays >= 3 && newLimit < settings.original_daily_task_limit) {
      newLimit = Math.min(newLimit + 1, settings.original_daily_task_limit);
      consecutiveDays = 0;
    }
  }

  await supabase
    .from('user_settings')
    .update({
      daily_task_limit: newLimit,
      consecutive_completion_days: consecutiveDays,
      last_completion_check_date: today,
      updated_at: new Date().toISOString(),
    })
    .eq('id', settings.id);
}

export async function getTodaysCompletedCount(): Promise<number> {
  const settings = await getUserSettings();
  if (!settings) return 0;

  const today = new Date().toISOString().split('T')[0];

  const { data: todayProgress } = await supabase
    .from('task_progress')
    .select('*')
    .eq('current_round', settings.current_round)
    .gte('last_completed_at', `${today}T00:00:00`)
    .lt('last_completed_at', `${today}T23:59:59`);

  return todayProgress?.length || 0;
}

export async function getWeeklyStats() {
  const settings = await getUserSettings();
  if (!settings) return { weeklyTarget: 0, weeklyCompleted: 0, dailyTarget: 0 };

  const now = new Date();
  const dayOfWeek = now.getDay();
  const mondayOffset = dayOfWeek === 0 ? -6 : 1 - dayOfWeek;

  const monday = new Date(now);
  monday.setDate(now.getDate() + mondayOffset);
  monday.setHours(0, 0, 0, 0);

  const sunday = new Date(monday);
  sunday.setDate(monday.getDate() + 6);
  sunday.setHours(23, 59, 59, 999);

  const mondayStr = monday.toISOString();
  const sundayStr = sunday.toISOString();

  const { data: weekProgress } = await supabase
    .from('task_progress')
    .select('*')
    .eq('current_round', settings.current_round)
    .gte('last_completed_at', mondayStr)
    .lte('last_completed_at', sundayStr);

  const weeklyTarget = settings.daily_task_limit * 7;
  const weeklyCompleted = weekProgress?.length || 0;
  const dailyTarget = settings.daily_task_limit;

  return {
    weeklyTarget,
    weeklyCompleted,
    dailyTarget,
  };
}

export async function getOverallProgress() {
  const settings = await getUserSettings();
  if (!settings) return { completed: 0, total: 0, percentage: 0 };

  const currentRound = settings.current_round;

  const { data: allTasks } = await supabase
    .from('tasks')
    .select('id, task_type, round_unlock')
    .lte('round_unlock', 5);

  if (!allTasks) return { completed: 0, total: 0, percentage: 0 };

  const { data: completedProgress } = await supabase
    .from('task_progress')
    .select('task_id, current_round, status')
    .eq('status', 'completed')
    .lte('current_round', 5);

  const completedTaskIds = new Set<string>();
  completedProgress?.forEach(p => {
    completedTaskIds.add(`${p.task_id}-${p.current_round}`);
  });

  let totalTasksNeeded = 0;
  let completedTasksCount = 0;

  for (let round = 1; round <= 5; round++) {
    const tasksForRound = allTasks.filter(task => {
      if (task.round_unlock > round) return false;

      if (round === 1) return true;
      if (round === 2 || round === 3) return task.task_type === 'mc';
      if (round >= 4) return task.task_type === 'mc' || task.task_type === 'tbs';
      return false;
    });

    totalTasksNeeded += tasksForRound.length;

    for (const task of tasksForRound) {
      if (completedTaskIds.has(`${task.id}-${round}`)) {
        completedTasksCount++;
      }
    }
  }

  const percentage = totalTasksNeeded > 0 ? Math.round((completedTasksCount / totalTasksNeeded) * 100) : 0;

  return {
    completed: completedTasksCount,
    total: totalTasksNeeded,
    percentage
  };
}

export async function getTodaysNotes() {
  const settings = await getUserSettings();
  if (!settings) return [];

  const today = new Date().toISOString().split('T')[0];

  const { data: todayProgress } = await supabase
    .from('task_progress')
    .select(`
      notes,
      last_completed_at,
      task:tasks(
        title,
        chapter:chapters(title)
      )
    `)
    .eq('current_round', settings.current_round)
    .gte('last_completed_at', `${today}T00:00:00`)
    .lt('last_completed_at', `${today}T23:59:59`)
    .not('notes', 'is', null)
    .order('last_completed_at', { ascending: false });

  if (!todayProgress) return [];

  return todayProgress.map(p => {
    const task = Array.isArray(p.task) ? p.task[0] : p.task;
    const chapter = task?.chapter ? (Array.isArray(task.chapter) ? task.chapter[0] : task.chapter) : null;

    return {
      taskTitle: task?.title || 'Unknown Task',
      chapterTitle: chapter?.title || 'Unknown Chapter',
      notes: p.notes || '',
      completedAt: p.last_completed_at || ''
    };
  });
}
