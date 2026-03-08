import { supabase } from './supabase';

const SINGLE_USER_ID = '00000000-0000-0000-0000-000000000001';

export interface PracticalEnglishFlashcard {
  id: string;
  chapter_id: string;
  topic: string;
  japanese_prompt: string;
  english_answer: string;
  key_phrases: string;
  order_index: number;
  created_at: string;
}

export interface PracticalEnglishProgress {
  id: string;
  user_id: string;
  flashcard_id: string;
  status: 'not_started' | 'practicing' | 'confident';
  last_practiced_at: string | null;
  practice_count: number;
  created_at: string;
}

export interface PracticalEnglishFlashcardWithProgress extends PracticalEnglishFlashcard {
  progress?: PracticalEnglishProgress;
}

export async function getPracticalEnglishFlashcardsByChapter(
  chapterId: string
): Promise<PracticalEnglishFlashcardWithProgress[]> {
  const { data: flashcards, error: flashcardsError } = await supabase
    .from('practical_english_flashcards')
    .select('*')
    .eq('chapter_id', chapterId)
    .order('order_index', { ascending: true });

  if (flashcardsError) throw flashcardsError;
  if (!flashcards) return [];

  const { data: progressData, error: progressError } = await supabase
    .from('practical_english_progress')
    .select('*')
    .eq('user_id', SINGLE_USER_ID)
    .in('flashcard_id', flashcards.map(f => f.id));

  if (progressError) throw progressError;

  const progressMap = new Map(
    progressData?.map(p => [p.flashcard_id, p]) || []
  );

  return flashcards.map(flashcard => ({
    ...flashcard,
    progress: progressMap.get(flashcard.id)
  }));
}

export async function updatePracticalEnglishProgress(
  flashcardId: string,
  status: 'not_started' | 'practicing' | 'confident'
): Promise<void> {
  const { data: existingProgress } = await supabase
    .from('practical_english_progress')
    .select('*')
    .eq('user_id', SINGLE_USER_ID)
    .eq('flashcard_id', flashcardId)
    .maybeSingle();

  if (existingProgress) {
    const { error } = await supabase
      .from('practical_english_progress')
      .update({
        status,
        last_practiced_at: new Date().toISOString(),
        practice_count: existingProgress.practice_count + 1
      })
      .eq('id', existingProgress.id);

    if (error) throw error;
  } else {
    const { error } = await supabase
      .from('practical_english_progress')
      .insert({
        user_id: SINGLE_USER_ID,
        flashcard_id: flashcardId,
        status,
        last_practiced_at: new Date().toISOString(),
        practice_count: 1
      });

    if (error) throw error;
  }
}

export async function getPracticalEnglishStats(chapterId: string) {
  const flashcards = await getPracticalEnglishFlashcardsByChapter(chapterId);

  const total = flashcards.length;
  const notStarted = flashcards.filter(f => !f.progress || f.progress.status === 'not_started').length;
  const practicing = flashcards.filter(f => f.progress?.status === 'practicing').length;
  const confident = flashcards.filter(f => f.progress?.status === 'confident').length;

  return {
    total,
    notStarted,
    practicing,
    confident,
    completionRate: total > 0 ? Math.round((confident / total) * 100) : 0
  };
}
