import { supabase } from './supabase';

export type StudyPlan = 'intensive' | 'moderate' | 'relaxed';

export interface StudyPlanConfig {
  name: string;
  duration: string;
  weeklyHours: number;
  dailyMinutes: number;
}

export const STUDY_PLANS: Record<StudyPlan, StudyPlanConfig> = {
  intensive: {
    name: '集中プラン',
    duration: '4.5ヶ月',
    weeklyHours: 25,
    dailyMinutes: Math.round((25 * 60) / 7),
  },
  moderate: {
    name: '標準プラン',
    duration: '5.5ヶ月',
    weeklyHours: 20,
    dailyMinutes: Math.round((20 * 60) / 7),
  },
  relaxed: {
    name: 'ゆったりプラン',
    duration: '8ヶ月',
    weeklyHours: 15,
    dailyMinutes: Math.round((15 * 60) / 7),
  },
};

const TASK_DURATION_ESTIMATES = {
  mcq: 3,
  tbs: 12,
};

export async function calculateAverageTaskDuration(): Promise<number> {
  const { data: lectures } = await supabase
    .from('lectures')
    .select('duration_minutes');

  const { data: tasks } = await supabase
    .from('tasks')
    .select('task_type');

  if (!lectures || !tasks) return 20;

  const videoDurations = lectures.map(l => l.duration_minutes);
  const avgVideoDuration = videoDurations.length > 0
    ? videoDurations.reduce((a, b) => a + b, 0) / videoDurations.length
    : 15;

  const taskTypeCounts = tasks.reduce((acc, task) => {
    acc[task.task_type] = (acc[task.task_type] || 0) + 1;
    return acc;
  }, {} as Record<string, number>);

  const totalTasks = tasks.length;
  const videoTasks = taskTypeCounts['lecture'] || 0;
  const mcqTasks = taskTypeCounts['mc'] || 0;
  const tbsTasks = taskTypeCounts['tbs'] || 0;

  const totalMinutes =
    (videoTasks * avgVideoDuration) +
    (mcqTasks * TASK_DURATION_ESTIMATES.mcq) +
    (tbsTasks * TASK_DURATION_ESTIMATES.tbs);

  return totalTasks > 0 ? Math.round(totalMinutes / totalTasks) : 20;
}

export async function calculateDailyTaskLimit(studyPlan: StudyPlan): Promise<number> {
  const config = STUDY_PLANS[studyPlan];
  const avgTaskDuration = await calculateAverageTaskDuration();

  const dailyTaskLimit = Math.round(config.dailyMinutes / avgTaskDuration);

  return Math.max(dailyTaskLimit, 1);
}

export async function updateStudyPlan(studyPlan: StudyPlan): Promise<void> {
  const dailyTaskLimit = await calculateDailyTaskLimit(studyPlan);

  const { error } = await supabase
    .from('user_settings')
    .update({
      study_plan: studyPlan,
      daily_task_limit: dailyTaskLimit,
    })
    .eq('id', 1);

  if (error) throw error;
}
