import { supabase } from './supabase';

export interface StudySession {
  id: string;
  date: string;
  duration_minutes: number;
  chapter_id: string | null;
  task_id: string | null;
  task_type: 'lecture' | 'mc' | 'tbs' | null;
  notes: string | null;
  created_at: string;
}

export interface StudyTimeStats {
  totalMinutes: number;
  totalHours: number;
  weeklyMinutes: number;
  weeklyHours: number;
  averagePerDay: number;
  daysStudied: number;
  targetWeeklyHours: number;
  weeklyProgress: number;
  estimatedCompletion: string | null;
  daysUntilExam: number | null;
  onTrack: boolean;
}

export async function recordStudySession(
  durationMinutes: number,
  chapterId?: string,
  taskId?: string,
  taskType?: 'lecture' | 'mc' | 'tbs',
  notes?: string
): Promise<void> {
  const { error } = await supabase.from('study_sessions').insert({
    duration_minutes: durationMinutes,
    chapter_id: chapterId || null,
    task_id: taskId || null,
    task_type: taskType || null,
    notes: notes || null,
  });

  if (error) throw error;

  const { data: settings } = await supabase
    .from('user_settings')
    .select('total_study_minutes')
    .maybeSingle();

  if (settings) {
    const newTotal = (settings.total_study_minutes || 0) + durationMinutes;
    await supabase
      .from('user_settings')
      .update({ total_study_minutes: newTotal })
      .eq('id', settings.id);
  }
}

export async function getStudyTimeStats(): Promise<StudyTimeStats> {
  const { data: settings } = await supabase
    .from('user_settings')
    .select('*')
    .maybeSingle();

  if (!settings) {
    return {
      totalMinutes: 0,
      totalHours: 0,
      weeklyMinutes: 0,
      weeklyHours: 0,
      averagePerDay: 0,
      daysStudied: 0,
      targetWeeklyHours: 20,
      weeklyProgress: 0,
      estimatedCompletion: null,
      daysUntilExam: null,
      onTrack: false,
    };
  }

  const totalMinutes = settings.total_study_minutes || 0;
  const totalHours = totalMinutes / 60;
  const targetWeeklyHours = settings.weekly_study_hours_target || 20;

  const now = new Date();
  const dayOfWeek = now.getDay();
  const mondayOffset = dayOfWeek === 0 ? -6 : 1 - dayOfWeek;

  const monday = new Date(now);
  monday.setDate(now.getDate() + mondayOffset);
  const mondayStr = monday.toISOString().split('T')[0];

  const { data: weeklySessions } = await supabase
    .from('study_sessions')
    .select('duration_minutes')
    .gte('date', mondayStr);

  const weeklyMinutes = weeklySessions?.reduce((sum, s) => sum + s.duration_minutes, 0) || 0;
  const weeklyHours = weeklyMinutes / 60;
  const weeklyProgress = (weeklyHours / targetWeeklyHours) * 100;

  const { data: allSessions } = await supabase
    .from('study_sessions')
    .select('date')
    .order('date', { ascending: true });

  const uniqueDates = new Set(allSessions?.map(s => s.date) || []);
  const daysStudied = uniqueDates.size;
  const averagePerDay = daysStudied > 0 ? totalMinutes / daysStudied : 0;

  const TOTAL_REQUIRED_HOURS = 450;
  const remainingHours = TOTAL_REQUIRED_HOURS - totalHours;
  let estimatedCompletion: string | null = null;

  if (weeklyHours > 0) {
    const weeksRemaining = remainingHours / weeklyHours;
    const completionDate = new Date();
    completionDate.setDate(completionDate.getDate() + weeksRemaining * 7);
    estimatedCompletion = completionDate.toISOString().split('T')[0];
  }

  let daysUntilExam: number | null = null;
  let onTrack = false;

  if (settings.target_exam_date) {
    const examDate = new Date(settings.target_exam_date);
    const diffTime = examDate.getTime() - today.getTime();
    daysUntilExam = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

    if (daysUntilExam > 0 && remainingHours > 0) {
      const requiredWeeklyHours = (remainingHours / daysUntilExam) * 7;
      onTrack = weeklyHours >= requiredWeeklyHours;
    }
  }

  return {
    totalMinutes,
    totalHours,
    weeklyMinutes,
    weeklyHours,
    averagePerDay,
    daysStudied,
    targetWeeklyHours,
    weeklyProgress,
    estimatedCompletion,
    daysUntilExam,
    onTrack,
  };
}

export async function getStudyHistory(days: number = 30): Promise<Array<{ date: string; minutes: number }>> {
  const startDate = new Date();
  startDate.setDate(startDate.getDate() - days);

  const { data: sessions } = await supabase
    .from('study_sessions')
    .select('date, duration_minutes')
    .gte('date', startDate.toISOString().split('T')[0])
    .order('date', { ascending: true });

  if (!sessions) return [];

  const dailyTotals = sessions.reduce((acc, session) => {
    const existing = acc.find(d => d.date === session.date);
    if (existing) {
      existing.minutes += session.duration_minutes;
    } else {
      acc.push({ date: session.date, minutes: session.duration_minutes });
    }
    return acc;
  }, [] as Array<{ date: string; minutes: number }>);

  return dailyTotals;
}

export async function updateStudyGoals(
  weeklyHoursTarget?: number,
  examDate?: string
): Promise<void> {
  const updates: Record<string, any> = {};

  if (weeklyHoursTarget !== undefined) {
    updates.weekly_study_hours_target = weeklyHoursTarget;
  }

  if (examDate !== undefined) {
    updates.target_exam_date = examDate || null;
  }

  const { data: settings } = await supabase
    .from('user_settings')
    .select('id')
    .maybeSingle();

  if (settings) {
    const { error } = await supabase
      .from('user_settings')
      .update(updates)
      .eq('id', settings.id);

    if (error) throw error;
  }
}
