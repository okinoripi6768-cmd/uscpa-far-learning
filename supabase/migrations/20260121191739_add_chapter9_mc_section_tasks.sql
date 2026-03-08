/*
  # Add Chapter 9 MC Tasks with Section Mapping
  
  1. Changes
    - Add 39 MC tasks for Chapter 9 with section-based task codes
    - Each task is linked to its corresponding lecture based on section number
    - All tasks have round_unlock = 1 for Round 1 availability
    - Task type is 'mc' (multiple choice)
  
  2. Task Distribution
    - Section 2 (Lecture 2): M9-2-1, M9-2-2, M9-2-3, M9-2-4, M9-2-5
    - Section 3 (Lecture 3): M9-3-1
    - Section 4 (Lecture 4): M9-4-1, M9-4-2
    - Section 5 (Lecture 5): M9-5-1 through M9-5-11
    - Section 6 (Lecture 6): M9-6-1 through M9-6-7
    - Section 7 (Lecture 7): M9-7-1 through M9-7-8
*/

DO $$
DECLARE
  v_chapter_id uuid;
  v_order_index int := 0;
BEGIN
  -- Get Chapter 9 ID
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 9;
  
  -- Get max order_index for Chapter 9
  SELECT COALESCE(MAX(order_index), 0) + 1 INTO v_order_index
  FROM tasks
  WHERE chapter_id = v_chapter_id;
  
  -- Insert MC tasks for Chapter 9 only if they don't exist
  IF NOT EXISTS (SELECT 1 FROM tasks WHERE chapter_id = v_chapter_id AND task_code = 'M9-2-1') THEN
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
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 2), 'M9-2-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 2), 'M9-2-2'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 2), 'M9-2-3'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 2), 'M9-2-4'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 2), 'M9-2-5'),
      -- Section 3
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 3), 'M9-3-1'),
      -- Section 4
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 4), 'M9-4-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 4), 'M9-4-2'),
      -- Section 5
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M9-5-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M9-5-2'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M9-5-3'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M9-5-4'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M9-5-5'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M9-5-6'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M9-5-7'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M9-5-8'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M9-5-9'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M9-5-10'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M9-5-11'),
      -- Section 6
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 6), 'M9-6-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 6), 'M9-6-2'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 6), 'M9-6-3'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 6), 'M9-6-4'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 6), 'M9-6-5'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 6), 'M9-6-6'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 6), 'M9-6-7'),
      -- Section 7
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M9-7-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M9-7-2'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M9-7-3'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M9-7-4'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M9-7-5'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M9-7-6'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M9-7-7'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M9-7-8')
    ) AS task_data(lecture_id, task_code);
  END IF;
END $$;
