/*
  # Add Chapter 4 Lecture URLs

  Updates the lectures table to add video URLs for all Chapter 4 lectures.
  
  1. Changes
    - Updates video_url for all 15 lectures in Chapter 4 (lecture_number 0-14)
    - Links each lecture to its corresponding video on the learning platform
  
  2. Notes
    - Chapter 4 covers 流動負債と偶発事象 (Current Liabilities and Contingencies)
    - All URLs follow the pattern: l04-{number}-01_r0.php
*/

-- Update Chapter 4 lecture URLs
UPDATE lectures
SET video_url = CASE lecture_number
  WHEN 0 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter4/_6003302010/l04-00-01_r0.php'
  WHEN 1 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter4/_6003302010/l04-01-01_r0.php'
  WHEN 2 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter4/_6003302010/l04-02-01_r0.php'
  WHEN 3 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter4/_6003302010/l04-03-01_r0.php'
  WHEN 4 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter4/_6003302010/l04-04-01_r0.php'
  WHEN 5 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter4/_6003302010/l04-05-01_r0.php'
  WHEN 6 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter4/_6003302010/l04-06-01_r0.php'
  WHEN 7 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter4/_6003302010/l04-07-01_r0.php'
  WHEN 8 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter4/_6003302010/l04-08-01_r0.php'
  WHEN 9 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter4/_6003302010/l04-09-01_r0.php'
  WHEN 10 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter4/_6003302010/l04-10-01_r0.php'
  WHEN 11 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter4/_6003302010/l04-11-01_r0.php'
  WHEN 12 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter4/_6003302010/l04-12-01_r0.php'
  WHEN 13 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter4/_6003302010/l04-13-01_r0.php'
  WHEN 14 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter4/_6003302010/l04-14-01_r0.php'
END
WHERE chapter_id = (SELECT id FROM chapters WHERE chapter_number = 4)
AND lecture_number BETWEEN 0 AND 14;