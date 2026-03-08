import { supabase } from './supabase';

const SINGLE_USER_ID = '00000000-0000-0000-0000-000000000001';

export interface InstantTranslationFlashcard {
  id: string;
  chapter_id: string;
  topic: string;
  japanese_sentence: string;
  english_translation: string;
  difficulty: 'basic' | 'intermediate' | 'advanced';
  keywords: string;
  order_index: number;
  created_at: string;
}

export interface InstantTranslationProgress {
  id: string;
  user_id: string;
  flashcard_id: string;
  status: 'not_started' | 'practicing' | 'mastered';
  last_practiced_at: string | null;
  practice_count: number;
  created_at: string;
}

export interface InstantTranslationFlashcardWithProgress extends InstantTranslationFlashcard {
  progress?: InstantTranslationProgress;
}

export async function getInstantTranslationFlashcardsByChapter(
  chapterId: string
): Promise<InstantTranslationFlashcardWithProgress[]> {
  const { data: flashcards, error: flashcardsError } = await supabase
    .from('instant_translation_flashcards')
    .select('*')
    .eq('chapter_id', chapterId)
    .order('order_index', { ascending: true });

  if (flashcardsError) throw flashcardsError;
  if (!flashcards) return [];

  const { data: progressData, error: progressError } = await supabase
    .from('instant_translation_progress')
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

export async function updateInstantTranslationProgress(
  flashcardId: string,
  status: 'not_started' | 'practicing' | 'mastered'
): Promise<void> {
  const { data: existingProgress } = await supabase
    .from('instant_translation_progress')
    .select('*')
    .eq('user_id', SINGLE_USER_ID)
    .eq('flashcard_id', flashcardId)
    .maybeSingle();

  if (existingProgress) {
    const { error } = await supabase
      .from('instant_translation_progress')
      .update({
        status,
        last_practiced_at: new Date().toISOString(),
        practice_count: existingProgress.practice_count + 1
      })
      .eq('id', existingProgress.id);

    if (error) throw error;
  } else {
    const { error } = await supabase
      .from('instant_translation_progress')
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

export async function getInstantTranslationStats(chapterId: string) {
  const flashcards = await getInstantTranslationFlashcardsByChapter(chapterId);

  const total = flashcards.length;
  const notStarted = flashcards.filter(f => !f.progress || f.progress.status === 'not_started').length;
  const practicing = flashcards.filter(f => f.progress?.status === 'practicing').length;
  const mastered = flashcards.filter(f => f.progress?.status === 'mastered').length;

  return {
    total,
    notStarted,
    practicing,
    mastered,
    completionRate: total > 0 ? Math.round((mastered / total) * 100) : 0
  };
}
