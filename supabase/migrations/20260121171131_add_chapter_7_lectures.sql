/*
  # Add Chapter 7 Lectures

  ## Overview
  This migration adds all lectures for Chapter 7.

  ## Changes
  
  1. Data Inserted
    - Chapter 7: 7 lectures (7-0 to 7-6)
*/

DO $$
DECLARE
  chapter_id_var uuid;
BEGIN
  -- Chapter 7
  SELECT id INTO chapter_id_var FROM chapters WHERE chapter_number = 7 LIMIT 1;
  IF chapter_id_var IS NOT NULL THEN
    INSERT INTO lectures (chapter_id, lecture_number, title, duration_minutes, order_index)
    VALUES
      (chapter_id_var, 0, '貨幣の時間価値', 4, 0),
      (chapter_id_var, 1, '1ドルあたりの将来価値', 7, 1),
      (chapter_id_var, 2, '1ドルあたりの現在価値', 12, 2),
      (chapter_id_var, 3, '毎期末積立の将来価値', 6, 3),
      (chapter_id_var, 4, '毎期末支払の現在価値', 9, 4),
      (chapter_id_var, 5, '毎期首積立の将来価値', 7, 5),
      (chapter_id_var, 6, '毎期首支払の現在価値', 8, 6)
    ON CONFLICT (chapter_id, lecture_number) DO NOTHING;
  END IF;
END $$;
