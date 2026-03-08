/*
  # Add notes column to task_progress table
  
  1. Changes
    - Add `notes` column to `task_progress` table for storing user notes on incorrect tasks
    - Notes will be displayed during review to help users remember why they got it wrong
  
  2. Security
    - No additional RLS changes needed as existing policies apply to the new column
*/

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'task_progress' AND column_name = 'notes'
  ) THEN
    ALTER TABLE task_progress ADD COLUMN notes text DEFAULT NULL;
  END IF;
END $$;
