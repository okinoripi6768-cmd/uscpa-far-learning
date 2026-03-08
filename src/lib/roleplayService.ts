import { supabase } from './supabase';

export interface RoleplayScenario {
  id: string;
  chapter_id: string;
  scenario_title: string;
  scenario_description: string;
  accounting_topic: string;
  consultant_role: string;
  client_role: string;
  key_vocabulary: string[];
  step1_client_question: string;
  step2_explanation_prompt: string;
  step3_followup_question: string;
  model_answer_step2: string;
  model_answer_step3: string;
  japanese_hints: string | null;
  technical_references: string | null;
  difficulty: 'basic' | 'intermediate' | 'advanced';
  estimated_time_minutes: number;
  order_index: number;
}

export interface RoleplayProgress {
  id: string;
  user_id: string | null;
  scenario_id: string;
  completed: boolean;
  attempts: number;
  last_practiced_at: string | null;
  my_answer_step2: string | null;
  my_answer_step3: string | null;
  personal_notes: string | null;
}

export interface RoleplayScenarioWithProgress extends RoleplayScenario {
  progress?: RoleplayProgress;
}

export interface RoleplayStats {
  total: number;
  notStarted: number;
  practicing: number;
  completed: number;
  completionRate: number;
}

export async function getRoleplayScenariosByChapter(
  chapterId: string
): Promise<RoleplayScenarioWithProgress[]> {
  const { data: scenarios, error: scenariosError } = await supabase
    .from('faas_roleplay_scenarios')
    .select('*')
    .eq('chapter_id', chapterId)
    .order('order_index', { ascending: true });

  if (scenariosError) throw scenariosError;
  if (!scenarios) return [];

  const { data: progressData } = await supabase
    .from('faas_roleplay_progress')
    .select('*')
    .in('scenario_id', scenarios.map(s => s.id));

  const scenariosWithProgress: RoleplayScenarioWithProgress[] = scenarios.map(scenario => ({
    ...scenario,
    progress: progressData?.find(p => p.scenario_id === scenario.id)
  }));

  return scenariosWithProgress;
}

export async function updateRoleplayProgress(
  scenarioId: string,
  updates: {
    completed?: boolean;
    my_answer_step2?: string;
    my_answer_step3?: string;
    personal_notes?: string;
  }
): Promise<void> {
  const { data: existingProgress } = await supabase
    .from('faas_roleplay_progress')
    .select('*')
    .eq('scenario_id', scenarioId)
    .maybeSingle();

  if (existingProgress) {
    const { error } = await supabase
      .from('faas_roleplay_progress')
      .update({
        ...updates,
        attempts: existingProgress.attempts + 1,
        last_practiced_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      })
      .eq('id', existingProgress.id);

    if (error) throw error;
  } else {
    const { error } = await supabase
      .from('faas_roleplay_progress')
      .insert({
        scenario_id: scenarioId,
        user_id: null,
        ...updates,
        attempts: 1,
        last_practiced_at: new Date().toISOString()
      });

    if (error) throw error;
  }
}

export async function getRoleplayStats(chapterId: string): Promise<RoleplayStats> {
  const scenarios = await getRoleplayScenariosByChapter(chapterId);

  const total = scenarios.length;
  const completed = scenarios.filter(s => s.progress?.completed === true).length;
  const practicing = scenarios.filter(s =>
    s.progress && !s.progress.completed && s.progress.attempts > 0
  ).length;
  const notStarted = total - completed - practicing;
  const completionRate = total > 0 ? Math.round((completed / total) * 100) : 0;

  return {
    total,
    notStarted,
    practicing,
    completed,
    completionRate
  };
}
