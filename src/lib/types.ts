import type { Database } from './database.types';

export type Chapter = Database['public']['Tables']['chapters']['Row'];
export type Lecture = Database['public']['Tables']['lectures']['Row'];
export type Task = Database['public']['Tables']['tasks']['Row'];
export type TaskProgress = Database['public']['Tables']['task_progress']['Row'];
export type UserSettings = Database['public']['Tables']['user_settings']['Row'];

export type TaskType = 'lecture' | 'mc' | 'tbs';
export type TaskStatus = 'pending' | 'active' | 'completed';
export type TaskResult = 'correct' | 'incorrect';

export interface DailyTask {
  task: Task;
  progress: TaskProgress;
  chapter: Chapter;
  lecture?: Lecture;
  isPriority: boolean;
}

export interface TaskWithProgress extends Task {
  progress: TaskProgress | null;
  chapter: Chapter;
}

export interface OverallProgress {
  completed: number;
  total: number;
  percentage: number;
}
