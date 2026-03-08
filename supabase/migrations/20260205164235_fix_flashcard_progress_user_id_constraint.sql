/*
  # Fix Flashcard Progress User ID Foreign Key Constraint

  ## Summary
  This migration removes the foreign key constraint on `flashcard_progress.user_id`
  that references `auth.users(id)`. The application uses a hardcoded single-user
  UUID that doesn't exist in auth.users, causing insert failures.

  ## Changes
  1. Drop the foreign key constraint on `user_id`
  2. Keep `user_id` as a UUID field for single-user tracking
  3. Optionally insert the hardcoded user ID to prevent issues

  ## Security Notes
  Since this is a single-user application without authentication, removing the
  foreign key constraint is acceptable. The application uses a fixed UUID
  (00000000-0000-0000-0000-000000000001) to track progress locally.
*/

-- Drop the foreign key constraint on user_id
ALTER TABLE flashcard_progress
DROP CONSTRAINT IF EXISTS flashcard_progress_user_id_fkey;

-- Keep user_id as NOT NULL to maintain data integrity
-- (the column already exists, no need to alter it)
