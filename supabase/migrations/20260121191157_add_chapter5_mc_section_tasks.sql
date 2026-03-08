/*
  # Add Chapter 5 MC Tasks with Section Mapping
  
  1. Changes
    - Add 40 MC tasks for Chapter 5 with section-based task codes (M5-1-1 through M5-20-1)
    - Each task is linked to its corresponding lecture based on section number
    - All tasks have round_unlock = 1 for Round 1 availability
    - Task type is 'mc' (multiple choice)
  
  2. Task Distribution
    - Section 1 (Lecture 1): M5-1-1, M5-1-2
    - Section 2 (Lecture 2): M5-2-1
    - Section 3 (Lecture 3): M5-3-1, M5-3-2
    - Section 4 (Lecture 4): M5-4-1, M5-4-2, M5-4-3
    - Section 6 (Lecture 6): M5-6-1, M5-6-2, M5-6-3
    - Section 7 (Lecture 7): M5-7-1, M5-7-2, M5-7-3, M5-7-4
    - Section 8 (Lecture 8): M5-8-1, M5-8-2
    - Section 9 (Lecture 9): M5-9-1, M5-9-2
    - Section 11 (Lecture 11): M5-11-1
    - Section 12 (Lecture 12): M5-12-1, M5-12-2
    - Section 13 (Lecture 13): M5-13-1, M5-13-2
    - Section 14 (Lecture 14): M5-14-1, M5-14-2
    - Section 15 (Lecture 15): M5-15-1, M5-15-2, M5-15-3
    - Section 16 (Lecture 16): M5-16-1
    - Section 18 (Lecture 18): M5-18-1, M5-18-2, M5-18-3, M5-18-4, M5-18-5
    - Section 19 (Lecture 19): M5-19-1, M5-19-2, M5-19-3, M5-19-4
    - Section 20 (Lecture 20): M5-20-1
*/

DO $$
DECLARE
  v_chapter_id uuid;
  v_order_index int := 0;
BEGIN
  -- Get Chapter 5 ID
  SELECT id INTO v_chapter_id FROM chapters WHERE chapter_number = 5;
  
  -- Get max order_index for Chapter 5
  SELECT COALESCE(MAX(order_index), 0) + 1 INTO v_order_index
  FROM tasks
  WHERE chapter_id = v_chapter_id;
  
  -- Insert MC tasks for Chapter 5 only if they don't exist
  IF NOT EXISTS (SELECT 1 FROM tasks WHERE chapter_id = v_chapter_id AND task_code = 'M5-1-1') THEN
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
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 1), 'M5-1-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 1), 'M5-1-2'),
      -- Section 2
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 2), 'M5-2-1'),
      -- Section 3
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 3), 'M5-3-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 3), 'M5-3-2'),
      -- Section 4
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 4), 'M5-4-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 4), 'M5-4-2'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 4), 'M5-4-3'),
      -- Section 6
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 6), 'M5-6-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 6), 'M5-6-2'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 6), 'M5-6-3'),
      -- Section 7
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M5-7-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M5-7-2'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M5-7-3'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 7), 'M5-7-4'),
      -- Section 8
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 8), 'M5-8-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 8), 'M5-8-2'),
      -- Section 9
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 9), 'M5-9-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 9), 'M5-9-2'),
      -- Section 11
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 11), 'M5-11-1'),
      -- Section 12
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 12), 'M5-12-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 12), 'M5-12-2'),
      -- Section 13
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 13), 'M5-13-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 13), 'M5-13-2'),
      -- Section 14
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 14), 'M5-14-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 14), 'M5-14-2'),
      -- Section 15
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 15), 'M5-15-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 15), 'M5-15-2'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 15), 'M5-15-3'),
      -- Section 16
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 16), 'M5-16-1'),
      -- Section 18
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 18), 'M5-18-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 18), 'M5-18-2'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 18), 'M5-18-3'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 18), 'M5-18-4'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 18), 'M5-18-5'),
      -- Section 19
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 19), 'M5-19-1'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 19), 'M5-19-2'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 19), 'M5-19-3'),
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 19), 'M5-19-4'),
      -- Section 20
      ((SELECT id FROM lectures WHERE chapter_id = v_chapter_id AND lecture_number = 20), 'M5-20-1')
    ) AS task_data(lecture_id, task_code);
  END IF;
END $$;
