import { supabase } from './supabase';

const SINGLE_USER_ID = '00000000-0000-0000-0000-000000000001';

export interface Flashcard {
  id: string;
  chapter_id: string;
  term: string;
  meaning: string;
  far_point: string;
  misconception: string;
  instant_phrase: string;
  order_index: number;
  created_at: string;
}

export interface FlashcardProgress {
  id: string;
  user_id: string;
  flashcard_id: string;
  status: 'not_started' | 'reviewing' | 'mastered';
  last_reviewed_at: string | null;
  review_count: number;
  created_at: string;
}

export interface FlashcardWithProgress extends Flashcard {
  progress?: FlashcardProgress;
}

export async function getFlashcardsByChapter(chapterId: string): Promise<FlashcardWithProgress[]> {
  const { data: flashcards, error: flashcardsError } = await supabase
    .from('flashcards')
    .select('*')
    .eq('chapter_id', chapterId)
    .order('order_index', { ascending: true });

  if (flashcardsError) throw flashcardsError;
  if (!flashcards || flashcards.length === 0) return [];

  const { data: progress, error: progressError } = await supabase
    .from('flashcard_progress')
    .select('*')
    .eq('user_id', SINGLE_USER_ID)
    .in('flashcard_id', flashcards.map(f => f.id));

  if (progressError) throw progressError;

  const progressMap = new Map(progress?.map(p => [p.flashcard_id, p]) || []);

  return flashcards.map(flashcard => ({
    ...flashcard,
    progress: progressMap.get(flashcard.id)
  }));
}

export async function updateFlashcardProgress(
  flashcardId: string,
  status: 'not_started' | 'reviewing' | 'mastered'
): Promise<void> {
  console.log('updateFlashcardProgress called with:', { flashcardId, status, userId: SINGLE_USER_ID });

  const { data: existing, error: selectError } = await supabase
    .from('flashcard_progress')
    .select('*')
    .eq('user_id', SINGLE_USER_ID)
    .eq('flashcard_id', flashcardId)
    .maybeSingle();

  if (selectError) {
    console.error('Error selecting existing progress:', selectError);
    throw selectError;
  }

  console.log('Existing progress:', existing);

  if (existing) {
    console.log('Updating existing progress...');
    const { error } = await supabase
      .from('flashcard_progress')
      .update({
        status,
        last_reviewed_at: new Date().toISOString(),
        review_count: existing.review_count + 1
      })
      .eq('id', existing.id);

    if (error) {
      console.error('Error updating progress:', error);
      throw error;
    }
    console.log('Successfully updated existing progress');
  } else {
    console.log('Inserting new progress...');
    const { error } = await supabase
      .from('flashcard_progress')
      .insert({
        user_id: SINGLE_USER_ID,
        flashcard_id: flashcardId,
        status,
        last_reviewed_at: new Date().toISOString(),
        review_count: 1
      });

    if (error) {
      console.error('Error inserting progress:', error);
      throw error;
    }
    console.log('Successfully inserted new progress');
  }
}

export async function getDailyFlashcards(selectedChapterIds: string[]): Promise<FlashcardWithProgress[]> {
  if (selectedChapterIds.length === 0) return [];

  const { data: flashcards, error: flashcardsError } = await supabase
    .from('flashcards')
    .select('*')
    .in('chapter_id', selectedChapterIds)
    .order('chapter_id', { ascending: true })
    .order('order_index', { ascending: true });

  if (flashcardsError) throw flashcardsError;
  if (!flashcards || flashcards.length === 0) return [];

  const { data: progress, error: progressError } = await supabase
    .from('flashcard_progress')
    .select('*')
    .eq('user_id', SINGLE_USER_ID)
    .in('flashcard_id', flashcards.map(f => f.id));

  if (progressError) throw progressError;

  const progressMap = new Map(progress?.map(p => [p.flashcard_id, p]) || []);

  const flashcardsWithProgress = flashcards.map(flashcard => ({
    ...flashcard,
    progress: progressMap.get(flashcard.id)
  }));

  const notStarted = flashcardsWithProgress.filter(f => !f.progress || f.progress.status === 'not_started');
  const reviewing = flashcardsWithProgress.filter(f => f.progress?.status === 'reviewing');

  const dailyFlashcards = [...notStarted, ...reviewing].slice(0, 10);

  return dailyFlashcards;
}

export async function getFlashcardStats(selectedChapterIds: string[]) {
  if (selectedChapterIds.length === 0) {
    return { total: 0, notStarted: 0, reviewing: 0, mastered: 0 };
  }

  const { data: flashcards, error: flashcardsError } = await supabase
    .from('flashcards')
    .select('id')
    .in('chapter_id', selectedChapterIds);

  if (flashcardsError) throw flashcardsError;
  if (!flashcards || flashcards.length === 0) return { total: 0, notStarted: 0, reviewing: 0, mastered: 0 };

  const { data: progress, error: progressError } = await supabase
    .from('flashcard_progress')
    .select('status')
    .eq('user_id', SINGLE_USER_ID)
    .in('flashcard_id', flashcards.map(f => f.id));

  if (progressError) throw progressError;

  const progressMap = new Map<string, number>();
  progress?.forEach(p => {
    progressMap.set(p.status, (progressMap.get(p.status) || 0) + 1);
  });

  const total = flashcards.length;
  const mastered = progressMap.get('mastered') || 0;
  const reviewing = progressMap.get('reviewing') || 0;
  const notStarted = total - mastered - reviewing;

  return { total, notStarted, reviewing, mastered };
}
