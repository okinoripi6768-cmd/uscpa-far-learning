/*
  # Add Chapter 7 MC Tasks with Section Mapping
  
  1. Changes
    - Add 2 MC tasks for Chapter 7 with section-based task codes
    - Each task is linked to its corresponding lecture based on section number
    - All tasks have round_unlock = 1 for Round 1 availability
    - Task type is 'mc' (multiple choice)
  
  2. Task Distribution
    - Section 2 (Lecture 2): M7-2-1
    - Section 4 (Lecture 4): M7-4-1
*/

DO $$
DECLARE
  v_chapter_id uuid;
  v_order_index int := 0;
BEGIN
  -- Get Chapter 7 ID
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 7;
  
  -- Get max order_index for Chapter 7
  SELECT COALESCE(MAX(order_index), 0) + 1 INTO v_order_index
  FROM tasks
  WHERE chapter_id = v_chapter_id;
  
  -- Insert MC tasks for Chapter 7 only if they don't exist
  IF NOT EXISTS (SELECT 1 FROM tasks WHERE chapter_id = v_chapter_id AND task_code = 'M7-2-1') THEN
    INSERT INTO tasks (chapter_id, lecture_id, task_type, task_code, title, round_unlock, order_index)
    SELECT 
      v_chapter_id,
      lecture_id,
      'mc',
      task_code,
      'MC Problem',
      1,
      v_order_index + ROW_NUMBER() OVER () - 1
    FROM (VALUES
      -- Section 2
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 2), 'M7-2-1'),
      -- Section 4
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 4), 'M7-4-1')
    ) AS task_data(lecture_id, task_code);
  END IF;
END $$;
