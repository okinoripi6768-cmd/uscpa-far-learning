/*
  # Add lecture URLs to chapters

  1. Updates to chapters table
    - Add lecture_url column to store the e-learning lecture link for each chapter
    - This allows direct navigation to the Abitus e-learning platform
*/

-- Add lecture_url column to chapters table
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'chapters' AND column_name = 'lecture_url'
  ) THEN
    ALTER TABLE chapters ADD COLUMN lecture_url text;
  END IF;
END $$;

-- Update lecture URLs for all chapters
UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter1/_6003302010/l01-00-01_r0.php'
WHERE chapter_number = 1;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter2/_6003302010/l02-00-01_r0.php'
WHERE chapter_number = 2;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter3/_6003302010/l03-00-01_r0.php'
WHERE chapter_number = 3;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter4/_6003302010/l04-00-01_r0.php'
WHERE chapter_number = 4;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter5/_6003302010/l05-00-01_r0.php'
WHERE chapter_number = 5;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter6/_6003302010/l06-00-01_r0.php'
WHERE chapter_number = 6;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter7/_6003302010/l07-00-01_r0.php'
WHERE chapter_number = 7;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter8/_6003302010/l08-00-01_r0.php'
WHERE chapter_number = 8;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter9/_6003302010/l09-00-01_r0.php'
WHERE chapter_number = 9;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter10/_6003302010/l10-00-01_r0.php'
WHERE chapter_number = 10;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter11/_6003302010/l11-00-01_r0.php'
WHERE chapter_number = 11;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter12/_6003302010/l12-00-01_r0.php'
WHERE chapter_number = 12;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter13/_6003302010/l13-00-01_r0.php'
WHERE chapter_number = 13;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter14/_6003302010/l14-00-01_r0.php'
WHERE chapter_number = 14;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter15/_6003302010/l15-00-01_r0.php'
WHERE chapter_number = 15;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter16/_6003302010/l16-00-01_r0.php'
WHERE chapter_number = 16;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter17/_6003302010/l17-00-01_r0.php'
WHERE chapter_number = 17;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter18/_6003302010/l18-00-01_r0.php'
WHERE chapter_number = 18;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter19/_6003302010/l19-00-01_r0.php'
WHERE chapter_number = 19;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter20/_6003302010/l20-00-01_r0.php'
WHERE chapter_number = 20;

UPDATE chapters SET lecture_url = 'https://study.abitus.co.jp/elearning/102_cpaevo/v1_mtyqfz/far13/l/chapter21/_6003302010/l21-00-01_r0.php'
WHERE chapter_number = 21;