/*
  # Add Chapter 13 Lectures

  ## Overview
  This migration adds all 14 lectures for Chapter 13 (Investment).

  ## Changes
  
  1. Data Inserted
    - 14 lectures for Chapter 13 (lecture numbers 0-13)
    - Each lecture includes title and duration in minutes
  
  ## Notes
  - This is a sample for Chapter 13
  - Other chapters will need similar lecture data
*/

-- Insert lectures for Chapter 13
-- First we need to get the chapter_id for chapter 13
DO $$
DECLARE
  chapter13_id uuid;
BEGIN
  -- Get the chapter_id for chapter 13
  SELECT id INTO chapter13_id FROM chapters WHERE chapter_number = 13 LIMIT 1;
  
  IF chapter13_id IS NOT NULL THEN
    -- Insert lectures if they don't exist
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter13_id, 0, '投資', 3, 0),
      (chapter13_id, 1, '有価証券の分類', 17, 1),
      (chapter13_id, 2, '満期保有目的有価証券の会計処理', 7, 2),
      (chapter13_id, 3, '売買目的有価証券の会計処理', 3, 3),
      (chapter13_id, 4, '売却可能有価証券（1）会計処理', 6, 4),
      (chapter13_id, 5, '売却可能有価証券（2）組替調整', 8, 5),
      (chapter13_id, 6, '有価証券の減損', 44, 6),
      (chapter13_id, 7, '投資分類の変更', 26, 7),
      (chapter13_id, 8, '公正価値オプション', 3, 8),
      (chapter13_id, 9, '投資金融商品に係る開示', 4, 9),
      (chapter13_id, 10, '持分法（1）適用要件', 6, 10),
      (chapter13_id, 11, '持分法（2）特徴', 8, 11),
      (chapter13_id, 12, '持分法（3）期中適用', 3, 12),
      (chapter13_id, 13, '持分法（4）時価評価法と持分法間の変更', 9, 13)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;
END $$;
