/*
  # Link tasks to lectures based on task_code

  1. Updates
    - Parse task_code format (e.g., M13-01-01, M13-02-01) to link tasks to lectures
    - M13-01-01 means: Chapter 13, Lecture 1, Question 1
    - Update lecture_id for all MC and TBS tasks based on task_code pattern
  
  2. Notes
    - Task code format: M[Chapter]-[Lecture]-[Question]
    - Only updates tasks where lecture_id is currently NULL
    - Safely handles cases where matching lecture doesn't exist
*/

-- Update MC and TBS tasks to link them to the correct lecture
-- Parse task_code pattern: M[Chapter]-[Lecture]-[Question]
UPDATE tasks t
SET lecture_id = l.id
FROM lectures l
JOIN chapters c ON l.chapter_id = c.id
WHERE t.task_type IN ('mc', 'tbs')
  AND t.lecture_id IS NULL
  AND t.task_code ~ '^M[0-9]+-[0-9]+-[0-9]+$'
  AND c.chapter_number = CAST(SUBSTRING(t.task_code FROM '^M([0-9]+)-') AS INTEGER)
  AND l.lecture_number = CAST(SUBSTRING(t.task_code FROM '^M[0-9]+-([0-9]+)-') AS INTEGER);