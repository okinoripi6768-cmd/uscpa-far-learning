import { supabase } from './supabase';
import type { Chapter, Task, TaskProgress, Lecture } from './types';

export interface ChapterProgress {
  chapter: Chapter;
  totalTasks: number;
  completedTasks: number;
  correctCount: number;
  incorrectCount: number;
  pendingReviewCount: number;
  totalLectures: number;
  completedLectures: number;
}

export interface LectureDetail {
  lecture: Lecture;
  mcTasks: Task[];
  tbsTasks: Task[];
  mcCompleted: number;
  mcCorrect: number;
  mcIncorrect: number;
  mcPendingReview: number;
  tbsCompleted: number;
  tbsCorrect: number;
  tbsIncorrect: number;
  tbsPendingReview: number;
}

export interface ChapterDetail {
  chapter: Chapter;
  lectures: LectureDetail[];
  totalMcTasks: number;
  completedMcTasks: number;
  totalTbsTasks: number;
  completedTbsTasks: number;
}

export interface RoundSummary {
  round: number;
  totalTasks: number;
  completedTasks: number;
  correctRate: number;
}

export async function getChapterProgress(currentRound: number): Promise<ChapterProgress[]> {
  const { data: chapters } = await supabase
    .from('chapters')
    .select('*')
    .order('order_index');

  if (!chapters) return [];

  const progressData: ChapterProgress[] = [];

  for (const chapter of chapters) {
    const { data: tasks } = await supabase
      .from('tasks')
      .select(`
        *,
        progress:task_progress(*)
      `)
      .eq('chapter_id', chapter.id)
      .lte('round_unlock', currentRound);

    const { data: lectures } = await supabase
      .from('lectures')
      .select('*')
      .eq('chapter_id', chapter.id)
      .order('order_index');

    if (!tasks) continue;

    const today = new Date().toISOString().split('T')[0];
    let completedTasks = 0;
    let correctCount = 0;
    let incorrectCount = 0;
    let pendingReviewCount = 0;

    for (const task of tasks) {
      const progress = Array.isArray(task.progress)
        ? task.progress.find((p: TaskProgress) => p.current_round === currentRound)
        : null;

      if (progress?.status === 'completed') {
        completedTasks++;
        if (progress.last_result === 'correct') correctCount++;
        if (progress.last_result === 'incorrect') incorrectCount++;
      }

      if (progress?.next_review_date && progress.next_review_date <= today) {
        pendingReviewCount++;
      }
    }

    let completedLectures = 0;
    if (lectures) {
      for (const lecture of lectures) {
        const lectureTasks = tasks.filter(t => t.lecture_id === lecture.id);
        if (lectureTasks.length > 0) {
          const allTasksCompleted = lectureTasks.every(task => {
            const progress = Array.isArray(task.progress)
              ? task.progress.find((p: TaskProgress) => p.current_round === currentRound)
              : null;
            return progress?.status === 'completed';
          });
          if (allTasksCompleted) {
            completedLectures++;
          }
        }
      }
    }

    progressData.push({
      chapter,
      totalTasks: tasks.length,
      completedTasks,
      correctCount,
      incorrectCount,
      pendingReviewCount,
      totalLectures: lectures?.length || 0,
      completedLectures,
    });
  }

  return progressData;
}

export async function getRoundSummary(): Promise<RoundSummary[]> {
  const summaries: RoundSummary[] = [];

  for (let round = 1; round <= 4; round++) {
    const { data: tasks } = await supabase
      .from('tasks')
      .select(`
        *,
        progress:task_progress(*)
      `)
      .eq('round_unlock', round);

    if (!tasks) continue;

    let completedTasks = 0;
    let correctCount = 0;
    let totalWithResults = 0;

    for (const task of tasks) {
      const progress = Array.isArray(task.progress)
        ? task.progress.find((p: TaskProgress) => p.current_round === round)
        : null;

      if (progress?.status === 'completed') {
        completedTasks++;
        if (progress.last_result) {
          totalWithResults++;
          if (progress.last_result === 'correct') correctCount++;
        }
      }
    }

    const correctRate = totalWithResults > 0 ? (correctCount / totalWithResults) * 100 : 0;

    summaries.push({
      round,
      totalTasks: tasks.length,
      completedTasks,
      correctRate,
    });
  }

  return summaries;
}

export async function getOverallStats(currentRound: number) {
  const { data: allTasks } = await supabase
    .from('tasks')
    .select(`
      *,
      progress:task_progress(*)
    `)
    .lte('round_unlock', currentRound);

  if (!allTasks) {
    return {
      totalTasks: 0,
      completedTasks: 0,
      correctCount: 0,
      incorrectCount: 0,
      pendingReviewCount: 0,
      correctRate: 0,
    };
  }

  const today = new Date().toISOString().split('T')[0];
  let completedTasks = 0;
  let correctCount = 0;
  let incorrectCount = 0;
  let pendingReviewCount = 0;

  for (const task of allTasks) {
    const progress = Array.isArray(task.progress)
      ? task.progress.find((p: TaskProgress) => p.current_round === currentRound)
      : null;

    if (progress?.status === 'completed') {
      completedTasks++;
      if (progress.last_result === 'correct') correctCount++;
      if (progress.last_result === 'incorrect') incorrectCount++;
    }

    if (progress?.next_review_date && progress.next_review_date <= today) {
      pendingReviewCount++;
    }
  }

  const totalWithResults = correctCount + incorrectCount;
  const correctRate = totalWithResults > 0 ? (correctCount / totalWithResults) * 100 : 0;

  return {
    totalTasks: allTasks.length,
    completedTasks,
    correctCount,
    incorrectCount,
    pendingReviewCount,
    correctRate,
  };
}

export async function getMCStats(currentRound: number) {
  const { data: mcTasks } = await supabase
    .from('tasks')
    .select(`
      *,
      progress:task_progress(*)
    `)
    .eq('task_type', 'mc')
    .lte('round_unlock', currentRound);

  if (!mcTasks) {
    return {
      totalTasks: 0,
      completedTasks: 0,
      correctCount: 0,
      incorrectCount: 0,
      pendingReviewCount: 0,
      correctRate: 0,
    };
  }

  const today = new Date().toISOString().split('T')[0];
  let completedTasks = 0;
  let correctCount = 0;
  let incorrectCount = 0;
  let pendingReviewCount = 0;

  for (const task of mcTasks) {
    const progress = Array.isArray(task.progress)
      ? task.progress.find((p: TaskProgress) => p.current_round === currentRound)
      : null;

    if (progress?.status === 'completed') {
      completedTasks++;
      if (progress.last_result === 'correct') correctCount++;
      if (progress.last_result === 'incorrect') incorrectCount++;
    }

    if (progress?.next_review_date && progress.next_review_date <= today) {
      pendingReviewCount++;
    }
  }

  const totalWithResults = correctCount + incorrectCount;
  const correctRate = totalWithResults > 0 ? (correctCount / totalWithResults) * 100 : 0;

  return {
    totalTasks: mcTasks.length,
    completedTasks,
    correctCount,
    incorrectCount,
    pendingReviewCount,
    correctRate,
  };
}

export async function bulkCompleteChapters(
  chapterIds: string[],
  currentRound: number,
  result: 'correct' | 'incorrect' = 'correct'
): Promise<{ success: boolean; tasksUpdated: number }> {
  let tasksUpdated = 0;

  for (const chapterId of chapterIds) {
    const { data: tasks } = await supabase
      .from('tasks')
      .select('*')
      .eq('chapter_id', chapterId)
      .lte('round_unlock', currentRound);

    if (!tasks || tasks.length === 0) continue;

    for (const task of tasks) {
      const { data: existingProgress } = await supabase
        .from('task_progress')
        .select('*')
        .eq('task_id', task.id)
        .eq('current_round', currentRound)
        .maybeSingle();

      const today = new Date().toISOString().split('T')[0];
      const nextReviewDate = new Date();
      nextReviewDate.setDate(nextReviewDate.getDate() + 7);
      const nextReview = nextReviewDate.toISOString().split('T')[0];

      if (existingProgress) {
        if (existingProgress.status !== 'completed') {
          await supabase
            .from('task_progress')
            .update({
              status: 'completed',
              last_result: result,
              completed_at: today,
              next_review_date: nextReview,
            })
            .eq('id', existingProgress.id);
          tasksUpdated++;
        }
      } else {
        await supabase
          .from('task_progress')
          .insert({
            task_id: task.id,
            current_round: currentRound,
            status: 'completed',
            last_result: result,
            completed_at: today,
            next_review_date: nextReview,
          });
        tasksUpdated++;
      }
    }
  }

  return { success: true, tasksUpdated };
}

export async function getChapterDetail(
  chapterId: string,
  currentRound: number
): Promise<ChapterDetail | null> {
  const { data: chapter } = await supabase
    .from('chapters')
    .select('*')
    .eq('id', chapterId)
    .maybeSingle();

  if (!chapter) return null;

  const { data: lectures } = await supabase
    .from('lectures')
    .select('*')
    .eq('chapter_id', chapterId)
    .order('order_index');

  if (!lectures) return null;

  const { data: tasks } = await supabase
    .from('tasks')
    .select(`
      *,
      progress:task_progress(*)
    `)
    .eq('chapter_id', chapterId)
    .lte('round_unlock', currentRound);

  if (!tasks) return null;

  const today = new Date().toISOString().split('T')[0];
  const lectureDetails: LectureDetail[] = [];
  let totalMcTasks = 0;
  let completedMcTasks = 0;
  let totalTbsTasks = 0;
  let completedTbsTasks = 0;

  for (const lecture of lectures) {
    const lectureTasks = tasks.filter(t => t.lecture_id === lecture.id);
    const mcTasks = lectureTasks.filter(t => t.task_type === 'mc');
    const tbsTasks = lectureTasks.filter(t => t.task_type === 'tbs');

    let mcCompleted = 0;
    let mcCorrect = 0;
    let mcIncorrect = 0;
    let mcPendingReview = 0;
    let tbsCompleted = 0;
    let tbsCorrect = 0;
    let tbsIncorrect = 0;
    let tbsPendingReview = 0;

    for (const task of mcTasks) {
      const progress = Array.isArray(task.progress)
        ? task.progress.find((p: TaskProgress) => p.current_round === currentRound)
        : null;

      if (progress?.status === 'completed') {
        mcCompleted++;
        completedMcTasks++;
        if (progress.last_result === 'correct') mcCorrect++;
        if (progress.last_result === 'incorrect') mcIncorrect++;
      }

      if (progress?.next_review_date && progress.next_review_date <= today) {
        mcPendingReview++;
      }
    }

    for (const task of tbsTasks) {
      const progress = Array.isArray(task.progress)
        ? task.progress.find((p: TaskProgress) => p.current_round === currentRound)
        : null;

      if (progress?.status === 'completed') {
        tbsCompleted++;
        completedTbsTasks++;
        if (progress.last_result === 'correct') tbsCorrect++;
        if (progress.last_result === 'incorrect') tbsIncorrect++;
      }

      if (progress?.next_review_date && progress.next_review_date <= today) {
        tbsPendingReview++;
      }
    }

    totalMcTasks += mcTasks.length;
    totalTbsTasks += tbsTasks.length;

    lectureDetails.push({
      lecture,
      mcTasks,
      tbsTasks,
      mcCompleted,
      mcCorrect,
      mcIncorrect,
      mcPendingReview,
      tbsCompleted,
      tbsCorrect,
      tbsIncorrect,
      tbsPendingReview,
    });
  }

  return {
    chapter,
    lectures: lectureDetails,
    totalMcTasks,
    completedMcTasks,
    totalTbsTasks,
    completedTbsTasks,
  };
}

export async function bulkCompleteLectures(
  lectureIds: string[],
  currentRound: number,
  result: 'correct' | 'incorrect' = 'correct'
): Promise<{ success: boolean; tasksUpdated: number }> {
  let tasksUpdated = 0;

  for (const lectureId of lectureIds) {
    const { data: tasks } = await supabase
      .from('tasks')
      .select('*')
      .eq('lecture_id', lectureId)
      .lte('round_unlock', currentRound);

    if (!tasks || tasks.length === 0) continue;

    for (const task of tasks) {
      const { data: existingProgress } = await supabase
        .from('task_progress')
        .select('*')
        .eq('task_id', task.id)
        .eq('current_round', currentRound)
        .maybeSingle();

      const today = new Date().toISOString().split('T')[0];
      const nextReviewDate = new Date();
      nextReviewDate.setDate(nextReviewDate.getDate() + 7);
      const nextReview = nextReviewDate.toISOString().split('T')[0];

      if (existingProgress) {
        if (existingProgress.status !== 'completed') {
          await supabase
            .from('task_progress')
            .update({
              status: 'completed',
              last_result: result,
              completed_at: today,
              next_review_date: nextReview,
            })
            .eq('id', existingProgress.id);
          tasksUpdated++;
        }
      } else {
        await supabase
          .from('task_progress')
          .insert({
            task_id: task.id,
            current_round: currentRound,
            status: 'completed',
            last_result: result,
            completed_at: today,
            next_review_date: nextReview,
          });
        tasksUpdated++;
      }
    }
  }

  return { success: true, tasksUpdated };
}
