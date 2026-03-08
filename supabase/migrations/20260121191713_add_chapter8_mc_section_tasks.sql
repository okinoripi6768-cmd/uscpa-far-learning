/*
  # Add Chapter 8 MC Tasks with Section Mapping
  
  1. Changes
    - Add 27 MC tasks for Chapter 8 with section-based task codes
    - Each task is linked to its corresponding lecture based on section number
    - All tasks have round_unlock = 1 for Round 1 availability
    - Task type is 'mc' (multiple choice)
  
  2. Task Distribution
    - Section 1 (Lecture 1): M8-1-1, M8-1-2
    - Section 2 (Lecture 2): M8-2-1
    - Section 3 (Lecture 3): M8-3-1
    - Section 4 (Lecture 4): M8-4-1
    - Section 5 (Lecture 5): M8-5-1
    - Section 6 (Lecture 6): M8-6-1
    - Section 7 (Lecture 7): M8-7-1
    - Section 8 (Lecture 8): M8-8-1
    - Section 9 (Lecture 9): M8-9-1, M8-9-2
    - Section 10 (Lecture 10): M8-10-1, M8-10-2, M8-10-3
    - Section 11 (Lecture 11): M8-11-1
    - Section 12 (Lecture 12): M8-12-1, M8-12-2
    - Section 13 (Lecture 13): M8-13-1, M8-13-2
    - Section 14 (Lecture 14): M8-14-1
    - Section 15 (Lecture 15): M8-15-1, M8-15-2
*/

DO $$
DECLARE
  v_chapter_id uuid;
  v_order_index int := 0;
BEGIN
  -- Get Chapter 8 ID
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 8;
  
  -- Get max order_index for Chapter 8
  SELECT COALESCE(MAX(order_index), 0) + 1 INTO v_order_index
  FROM tasks
  WHERE chapter_id = v_chapter_id;
  
  -- Insert MC tasks for Chapter 8 only if they don't exist
  IF NOT EXISTS (SELECT 1 FROM tasks WHERE chapter_id = v_chapter_id AND task_code = 'M8-1-1') THEN
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
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 1), 'M8-1-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 1), 'M8-1-2'),
      -- Section 2
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 2), 'M8-2-1'),
      -- Section 3
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 3), 'M8-3-1'),
      -- Section 4
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 4), 'M8-4-1'),
      -- Section 5
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 5), 'M8-5-1'),
      -- Section 6
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 6), 'M8-6-1'),
      -- Section 7
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M8-7-1'),
      -- Section 8
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 8), 'M8-8-1'),
      -- Section 9
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 9), 'M8-9-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 9), 'M8-9-2'),
      -- Section 10
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 10), 'M8-10-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 10), 'M8-10-2'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 10), 'M8-10-3'),
      -- Section 11
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 11), 'M8-11-1'),
      -- Section 12
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 12), 'M8-12-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 12), 'M8-12-2'),
      -- Section 13
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 13), 'M8-13-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 13), 'M8-13-2'),
      -- Section 14
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 14), 'M8-14-1'),
      -- Section 15
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 15), 'M8-15-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 15), 'M8-15-2')
    ) AS task_data(lecture_id, task_code);
  END IF;
END $$;
