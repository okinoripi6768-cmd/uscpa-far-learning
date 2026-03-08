/*
  # Add Chapter 4 MC Tasks with Section Mapping
  
  1. Changes
    - Add 28 MC tasks for Chapter 4 with section-based task codes (M4-1-1 through M4-13-1)
    - Each task is linked to its corresponding lecture based on section number
    - All tasks have round_unlock = 1 for Round 1 availability
    - Task type is 'mc' (multiple choice)
  
  2. Task Distribution
    - Section 1 (Lecture 1): M4-1-1, M4-1-2
    - Section 2 (Lecture 2): M4-2-1
    - Section 3 (Lecture 3): M4-3-1
    - Section 4 (Lecture 4): M4-4-1, M4-4-2
    - Section 5 (Lecture 5): M4-5-1, M4-5-2
    - Section 6 (Lecture 6): M4-6-1
    - Section 7 (Lecture 7): M4-7-1, M4-7-2, M4-7-3, M4-7-4
    - Section 8 (Lecture 8): M4-8-1, M4-8-2
    - Section 9 (Lecture 9): M4-9-1 through M4-9-8
    - Section 10 (Lecture 10): M4-10-1, M4-10-2
    - Section 12 (Lecture 12): M4-12-1, M4-12-2
    - Section 13 (Lecture 13): M4-13-1
*/

DO $$
DECLARE
  v_chapter_id uuid;
  v_order_index int := 0;
BEGIN
  -- Get Chapter 4 ID
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 4;
  
  -- Get max order_index for Chapter 4
  SELECT COALESCE(MAX(order_index), 0) + 1 INTO v_order_index
  FROM tasks
  WHERE chapter_id = v_chapter_id;
  
  -- Insert MC tasks for Chapter 4 only if they don't exist
  IF NOT EXISTS (SELECT 1 FROM tasks WHERE chapter_id = v_chapter_id AND task_code = 'M4-1-1') THEN
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
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 1), 'M4-1-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 1), 'M4-1-2'),
      -- Section 2
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 2), 'M4-2-1'),
      -- Section 3
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 3), 'M4-3-1'),
      -- Section 4
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 4), 'M4-4-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 4), 'M4-4-2'),
      -- Section 5
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M4-5-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M4-5-2'),
      -- Section 6
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 6), 'M4-6-1'),
      -- Section 7
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M4-7-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M4-7-2'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M4-7-3'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M4-7-4'),
      -- Section 8
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 8), 'M4-8-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 8), 'M4-8-2'),
      -- Section 9
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 9), 'M4-9-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 9), 'M4-9-2'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 9), 'M4-9-3'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 9), 'M4-9-4'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 9), 'M4-9-5'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 9), 'M4-9-6'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 9), 'M4-9-7'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 9), 'M4-9-8'),
      -- Section 10
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 10), 'M4-10-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 10), 'M4-10-2'),
      -- Section 12
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 12), 'M4-12-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 12), 'M4-12-2'),
      -- Section 13
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 13), 'M4-13-1')
    ) AS task_data(lecture_id, task_code);
  END IF;
END $$;
