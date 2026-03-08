/*
  # Update Chapters 13-21 with Actual Lecture Durations

  1. Changes
    - Chapter 13 (Investments): 147分 (実績ベース)
    - Chapter 14 (Consolidated Financial Statements): 85分 (実績ベース)
    - Chapter 15 (Deferred Taxes): 158分 (実績ベース)
    - Chapter 16 (Cash Flow Statement): 89分 (実績ベース)
    - Chapter 17 (Accounting Changes and Error Corrections): 53分 (実績ベース)
    - Chapter 18 (Other Topics): 21分 (実績ベース)
    - Chapter 19 (Financial Metrics): 121分 (実績ベース)
    - Chapter 20 (Not-for-Profit Organizations): 140分 (実績ベース)
    - Chapter 21 (Government Accounting): 95分 (実績ベース)

  2. Notes
    - セクション別の実績時間を合計した正確な時間に更新
    - Chapter 18とChapter 19の一部セクションには時間記載がなかったため、記載のあるセクションのみで合計
*/

-- Update Chapter 13: Investments
UPDATE chapters 
SET lecture_duration_minutes = 147 
WHERE chapter_number = 13;

-- Update Chapter 14: Consolidated Financial Statements and Business Combinations
UPDATE chapters 
SET lecture_duration_minutes = 85 
WHERE chapter_number = 14;

-- Update Chapter 15: Deferred Taxes
UPDATE chapters 
SET lecture_duration_minutes = 158 
WHERE chapter_number = 15;

-- Update Chapter 16: Cash Flow Statement
UPDATE chapters 
SET lecture_duration_minutes = 89 
WHERE chapter_number = 16;

-- Update Chapter 17: Accounting Changes and Error Corrections
UPDATE chapters 
SET lecture_duration_minutes = 53 
WHERE chapter_number = 17;

-- Update Chapter 18: Other Topics
UPDATE chapters 
SET lecture_duration_minutes = 21 
WHERE chapter_number = 18;

-- Update Chapter 19: Financial Metrics and Analysis
UPDATE chapters 
SET lecture_duration_minutes = 121 
WHERE chapter_number = 19;

-- Update Chapter 20: Not-for-Profit Organizations
UPDATE chapters 
SET lecture_duration_minutes = 140 
WHERE chapter_number = 20;

-- Update Chapter 21: Government Accounting
UPDATE chapters 
SET lecture_duration_minutes = 95 
WHERE chapter_number = 21;