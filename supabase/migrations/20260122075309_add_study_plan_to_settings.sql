/*
  # Add study plan to user settings

  1. Changes
    - Add `study_plan` column to `user_settings` table
      - Type: text with check constraint
      - Values: 'intensive' (4.5 months, 25 hours/week), 'moderate' (5.5 months, 20 hours/week), 'relaxed' (8 months, 15 hours/week)
      - Default: 'moderate'
    
  2. Notes
    - The study plan determines weekly study hours target
    - Daily task limit will be auto-calculated based on this plan
*/

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'user_settings' AND column_name = 'study_plan'
  ) THEN
    ALTER TABLE user_settings 
    ADD COLUMN study_plan text DEFAULT 'moderate' 
    CHECK (study_plan IN ('intensive', 'moderate', 'relaxed'));
  END IF;
END $$;