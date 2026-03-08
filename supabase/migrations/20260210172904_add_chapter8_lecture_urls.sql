/*
  # Add Chapter 8 Lecture URLs

  ## Overview
  This migration adds video URLs for all Chapter 8 (Bonds) lectures.

  ## Changes
  
  1. Updates
    - Add video_url for all 16 lectures in Chapter 8 (lecture numbers 0-15)
    - Covers topics from basic bond concepts to early redemption
  
  ## Important Notes
  - Chapter 8 lectures cover comprehensive bond accounting topics
  - URLs link to Abitus e-learning platform lecture videos
  - All lecture records already exist, only updating video_url field
*/

-- Update Chapter 8 lecture URLs
UPDATE lectures
SET video_url = CASE lecture_number
  WHEN 0 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-00-01_r0.php'
  WHEN 1 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-01-01_r0.php'
  WHEN 2 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-02-01_r0.php'
  WHEN 3 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-03-01_r0.php'
  WHEN 4 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-04-01_r0.php'
  WHEN 5 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-05-01_r0.php'
  WHEN 6 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-06-01_r0.php'
  WHEN 7 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-07-01_r0.php'
  WHEN 8 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-08-01_r0.php'
  WHEN 9 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-09-01_r0.php'
  WHEN 10 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-10-01_r0.php'
  WHEN 11 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-11-01_r0.php'
  WHEN 12 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-12-01_r0.php'
  WHEN 13 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-13-01_r0.php'
  WHEN 14 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-14-01_r0.php'
  WHEN 15 THEN 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-15-01_r0.php'
END
WHERE chapter_id = (SELECT id FROM chapters WHERE title = 'Chapter 8: Bonds')
  AND lecture_number BETWEEN 0 AND 15;