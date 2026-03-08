/*
  # Update Chapter 7 with Actual Lecture Duration

  1. Changes
    - Chapter 7 (Time Value of Money): 53分 (実績ベース)
      - 7-0: 4分
      - 7-1: 7分
      - 7-2: 12分
      - 7-3: 6分
      - 7-4: 9分
      - 7-5: 7分
      - 7-6: 8分

  2. Notes
    - セクション別の実績時間を合計した正確な時間に更新
*/

-- Update Chapter 7: Time Value of Money
UPDATE chapters 
SET lecture_duration_minutes = 53 
WHERE chapter_number = 7;