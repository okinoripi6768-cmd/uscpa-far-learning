/*
  # Create Flashcards Schema for FAR English Terminology

  1. New Tables
    - `flashcards`
      - `id` (uuid, primary key)
      - `chapter_id` (uuid, foreign key to chapters)
      - `term` (text) - The English term on the front
      - `meaning` (text) - Japanese meaning/explanation
      - `far_point` (text) - FAR topic switch/key points
      - `misconception` (text) - Common misunderstandings
      - `instant_phrase` (text) - Quick decision phrase
      - `order_index` (integer) - Display order within chapter
      - `created_at` (timestamptz)
    
    - `flashcard_progress`
      - `id` (uuid, primary key)
      - `user_id` (uuid, references auth.users)
      - `flashcard_id` (uuid, foreign key to flashcards)
      - `status` (text) - 'not_started', 'reviewing', 'mastered'
      - `last_reviewed_at` (timestamptz)
      - `review_count` (integer) - Number of times reviewed
      - `created_at` (timestamptz)

  2. Security
    - Enable RLS on both tables
    - Users can read all flashcards
    - Users can only manage their own progress
*/

-- Create flashcards table
CREATE TABLE IF NOT EXISTS flashcards (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  chapter_id uuid REFERENCES chapters(id) ON DELETE CASCADE NOT NULL,
  term text NOT NULL,
  meaning text NOT NULL,
  far_point text NOT NULL,
  misconception text NOT NULL,
  instant_phrase text NOT NULL,
  order_index integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Create flashcard_progress table
CREATE TABLE IF NOT EXISTS flashcard_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  flashcard_id uuid REFERENCES flashcards(id) ON DELETE CASCADE NOT NULL,
  status text NOT NULL DEFAULT 'not_started' CHECK (status IN ('not_started', 'reviewing', 'mastered')),
  last_reviewed_at timestamptz,
  review_count integer DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, flashcard_id)
);

-- Enable RLS
ALTER TABLE flashcards ENABLE ROW LEVEL SECURITY;
ALTER TABLE flashcard_progress ENABLE ROW LEVEL SECURITY;

-- Flashcards policies (all authenticated users can read)
CREATE POLICY "Anyone can view flashcards"
  ON flashcards FOR SELECT
  TO authenticated
  USING (true);

-- Flashcard progress policies (users can only manage their own)
CREATE POLICY "Users can view own flashcard progress"
  ON flashcard_progress FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own flashcard progress"
  ON flashcard_progress FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own flashcard progress"
  ON flashcard_progress FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own flashcard progress"
  ON flashcard_progress FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_flashcards_chapter_id ON flashcards(chapter_id);
CREATE INDEX IF NOT EXISTS idx_flashcard_progress_user_id ON flashcard_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_flashcard_progress_flashcard_id ON flashcard_progress(flashcard_id);