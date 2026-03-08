/*
  # Restructure tasks to be section-based
  
  1. Changes
    - Delete old chapter-level lecture tasks (L1, L2, etc.)
    - Create new lecture tasks for each section in lectures table
    - Link existing MC/TBS tasks to their corresponding lectures
    - Update order_index to properly sequence tasks
  
  2. Task Code Format
    - Lecture tasks: L[Chapter]-[Section] (e.g., L1-00, L1-01)
    - MC tasks: MC[Chapter]-[Section] or M[Chapter]-[Section]-[Question]
    - TBS tasks: TBS[Chapter]-[Section] or T[Chapter]-[Section]-[Question]
  
  3. Order Index Logic
    - Based on: (chapter_number * 10000) + (lecture_number * 100) + task_type_order
    - task_type_order: lecture=1, mc=2, tbs=3
*/

-- Step 1: Delete old chapter-level lecture tasks
DELETE FROM tasks 
WHERE task_type = 'lecture' 
  AND lecture_id IS NULL
  AND (task_code ~ '^L[0-9]+-[0-9]+$' OR task_code ~ '^L[0-9]+$');

-- Step 2: Create lecture tasks for each section
INSERT INTO tasks (task_code, task_type, title, round_unlock, lecture_id, chapter_id, order_index, created_at)
SELECT 
  'L' || c.chapter_number || '-' || LPAD(l.lecture_number::TEXT, 2, '0') as task_code,
  'lecture' as task_type,
  'Ch' || c.chapter_number || '-' || l.lecture_number || ': ' || l.title as title,
  1 as round_unlock,
  l.id as lecture_id,
  c.id as chapter_id,
  (c.chapter_number * 10000) + (l.lecture_number * 100) + 1 as order_index,
  NOW() as created_at
FROM lectures l
JOIN chapters c ON l.chapter_id = c.id
WHERE NOT EXISTS (
  SELECT 1 FROM tasks t 
  WHERE t.lecture_id = l.id AND t.task_type = 'lecture'
);

-- Step 3: Update MC/TBS tasks to link to lectures
-- Handle old format: MC1-01, MC1-02, etc.
UPDATE tasks t
SET lecture_id = l.id,
    order_index = (c.chapter_number * 10000) + (l.lecture_number * 100) + 
                  CASE WHEN t.task_type = 'mc' THEN 2 ELSE 3 END
FROM lectures l
JOIN chapters c ON l.chapter_id = c.id
WHERE t.lecture_id IS NULL
  AND t.task_type IN ('mc', 'tbs')
  AND t.task_code ~ '^M[C]?[0-9]+-[0-9]+$'
  AND c.chapter_number = CAST(SUBSTRING(t.task_code FROM '^M[C]?([0-9]+)-') AS INTEGER)
  AND l.lecture_number = CAST(SUBSTRING(t.task_code FROM '^M[C]?[0-9]+-([0-9]+)$') AS INTEGER);

-- Step 4: Update order_index for MC/TBS tasks that are already linked to lectures
UPDATE tasks t
SET order_index = (c.chapter_number * 10000) + (l.lecture_number * 100) + 
                  CASE WHEN t.task_type = 'mc' THEN 2 ELSE 3 END
FROM lectures l
JOIN chapters c ON l.chapter_id = c.id
WHERE t.lecture_id = l.id
  AND t.task_type IN ('mc', 'tbs');