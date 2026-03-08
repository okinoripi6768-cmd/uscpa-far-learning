/*
  # Add Lectures Table

  ## Overview
  This migration adds a lectures table to support multiple lectures per chapter.
  Each chapter can have multiple lectures (e.g., Chapter 13 has 14 lectures: 13-0 to 13-13).

  ## Changes
  
  1. New Tables
    - `lectures`
      - `id` (uuid, primary key)
      - `chapter_id` (uuid, foreign key to chapters)
      - `lecture_number` (int) - The lecture number within the chapter (0, 1, 2, etc.)
      - `title` (text) - Lecture title
      - `duration_minutes` (int) - Video duration in minutes
      - `video_url` (text) - Optional URL to the lecture video
      - `order_index` (int) - For ordering lectures
      - `created_at` (timestamptz)
  
  2. Modifications
    - Add `lecture_id` column to `tasks` table (nullable for backward compatibility)
    - Tasks can now be associated with specific lectures
  
  3. Security
    - Enable RLS on lectures table
    - Add policies for public access
*/

-- Create lectures table
CREATE TABLE IF NOT EXISTS lectures (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  chapter_id uuid REFERENCES chapters(id) ON DELETE CASCADE NOT NULL,
  lecture_number int NOT NULL,
  title text NOT NULL,
  duration_minutes int DEFAULT 0,
  video_url text,
  order_index int NOT NULL,
  created_at timestamptz DEFAULT now(),
  UNIQUE(chapter_id, lecture_number)
);

-- Add lecture_id to tasks table
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'tasks' AND column_name = 'lecture_id'
  ) THEN
    ALTER TABLE tasks ADD COLUMN lecture_id uuid REFERENCES lectures(id) ON DELETE CASCADE;
  END IF;
END $$;

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_lectures_chapter_id ON lectures(chapter_id);
CREATE INDEX IF NOT EXISTS idx_tasks_lecture_id ON tasks(lecture_id);

-- Enable Row Level Security
ALTER TABLE lectures ENABLE ROW LEVEL SECURITY;

-- Create policies for lectures
CREATE POLICY "Allow public read access on lectures"
  ON lectures FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow public insert on lectures"
  ON lectures FOR INSERT
  TO public
  WITH CHECK (true);

CREATE POLICY "Allow public update on lectures"
  ON lectures FOR UPDATE
  TO public
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow public delete on lectures"
  ON lectures FOR DELETE
  TO public
  USING (true);
