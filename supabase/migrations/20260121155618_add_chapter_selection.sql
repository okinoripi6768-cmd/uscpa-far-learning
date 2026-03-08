/*
  # Add Chapter Selection Feature

  1. Changes
    - Add `excluded_chapters` column to `user_settings` table
      - Type: jsonb (array of chapter IDs)
      - Default: empty array
      - Allows users to exclude chapters they've mastered or want to skip
  
  2. Purpose
    - Enable users to focus on specific chapters
    - Skip already mastered content
    - Improve learning efficiency
*/

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'user_settings' AND column_name = 'excluded_chapters'
  ) THEN
    ALTER TABLE user_settings ADD COLUMN excluded_chapters jsonb DEFAULT '[]'::jsonb;
  END IF;
END $$;
