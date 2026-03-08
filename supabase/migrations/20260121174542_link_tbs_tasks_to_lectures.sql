/*
  # Link TBS tasks to lectures
  
  1. Updates
    - Parse TBS task_code format (e.g., TBS1-01, TBS2-01) to link to lectures
    - Link to the specified section within each chapter
  
  2. Notes
    - Task code format: TBS[Chapter]-[Section]
    - Only updates tasks where lecture_id is currently NULL
*/

-- Update TBS tasks to link them to the correct lecture
-- Parse task_code pattern: TBS[Chapter]-[Section]
UPDATE tasks t
SET lecture_id = l.id,
    order_index = (c.chapter_number * 10000) + (l.lecture_number * 100) + 3
FROM lectures l
JOIN chapters c ON l.chapter_id = c.id
WHERE t.task_type = 'tbs'
  AND t.lecture_id IS NULL
  AND t.task_code ~ '^TBS[0-9]+-[0-9]+$'
  AND c.chapter_number = CAST(SUBSTRING(t.task_code FROM '^TBS([0-9]+)-') AS INTEGER)
  AND l.lecture_number = CAST(SUBSTRING(t.task_code FROM '^TBS[0-9]+-([0-9]+)$') AS INTEGER);