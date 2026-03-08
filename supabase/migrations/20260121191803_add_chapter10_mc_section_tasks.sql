/*
  # Add Chapter 10 MC Tasks with Section Mapping
  
  1. Changes
    - Add 18 MC tasks for Chapter 10 with section-based task codes
    - Each task is linked to its corresponding lecture based on section number
    - All tasks have round_unlock = 1 for Round 1 availability
    - Task type is 'mc' (multiple choice)
  
  2. Task Distribution
    - Section 1 (Lecture 1): M10-1-1 through M10-1-6
    - Section 2 (Lecture 2): M10-2-1
    - Section 3 (Lecture 3): M10-3-1 through M10-3-7
    - Section 5 (Lecture 5): M10-5-1 through M10-5-3
    - Section 6 (Lecture 6): M10-6-1
*/

DO $$
DECLARE
  v_chapter_id uuid;
  v_order_index int := 0;
BEGIN
  -- Get Chapter 10 ID
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 10;
  
  -- Get max order_index for Chapter 10
  SELECT COALESCE(MAX(order_index), 0) + 1 INTO v_order_index
  FROM tasks
  WHERE chapter_id = v_chapter_id;
  
  -- Insert MC tasks for Chapter 10 only if they don't exist
  IF NOT EXISTS (SELECT 1 FROM tasks WHERE chapter_id = v_chapter_id AND task_code = 'M10-1-1') THEN
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
      -- Section 1
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 1), 'M10-1-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 1), 'M10-1-2'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 1), 'M10-1-3'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 1), 'M10-1-4'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 1), 'M10-1-5'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 1), 'M10-1-6'),
      -- Section 2
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 2), 'M10-2-1'),
      -- Section 3
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 3), 'M10-3-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 3), 'M10-3-2'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 3), 'M10-3-3'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 3), 'M10-3-4'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 3), 'M10-3-5'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 3), 'M10-3-6'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 3), 'M10-3-7'),
      -- Section 5
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M10-5-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M10-5-2'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M10-5-3'),
      -- Section 6
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 6), 'M10-6-1')
    ) AS task_data(lecture_id, task_code);
  END IF;
END $$;
