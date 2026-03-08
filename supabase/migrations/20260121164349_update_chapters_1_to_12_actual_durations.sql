/*
  # Update Chapters 1-12 with Actual Lecture Durations

  1. Changes
    - Chapter 1: 90分 → 87分 (実績ベース)
    - Chapter 2: 120分 → 132分 (実績ベース)
    - Chapter 3: 90分 → 331分 (実績ベース)
    - Chapter 4: 105分 → 107分 (実績ベース)
    - Chapter 5: 120分 → 175分 (実績ベース)
    - Chapter 6: 60分 → 31分 (実績ベース)
    - Chapter 8: 312分 → 180分 (実績ベース)
    - Chapter 9: 468分 → 190分 (実績ベース)
    - Chapter 10: 294分 → 169分 (実績ベース)
    - Chapter 11: 546分 → 413分 (実績ベース)
    - Chapter 12: 690分 → 268分 (実績ベース)

  2. Notes
    - セクション別の実績時間を合計した正確な時間に更新
    - Chapter 7以降のデータは次のマイグレーションで更新予定
*/

-- Update Chapter 1: Conceptual Framework
UPDATE chapters 
SET lecture_duration_minutes = 87 
WHERE chapter_number = 1;

-- Update Chapter 2: Financial Statements
UPDATE chapters 
SET lecture_duration_minutes = 132 
WHERE chapter_number = 2;

-- Update Chapter 3: Cash and Receivables
UPDATE chapters 
SET lecture_duration_minutes = 331 
WHERE chapter_number = 3;

-- Update Chapter 4: Inventory
UPDATE chapters 
SET lecture_duration_minutes = 107 
WHERE chapter_number = 4;

-- Update Chapter 5: Fixed Assets
UPDATE chapters 
SET lecture_duration_minutes = 175 
WHERE chapter_number = 5;

-- Update Chapter 6: Intangible Assets
UPDATE chapters 
SET lecture_duration_minutes = 31 
WHERE chapter_number = 6;

-- Update Chapter 8: Bonds
UPDATE chapters 
SET lecture_duration_minutes = 180 
WHERE chapter_number = 8;

-- Update Chapter 9: Lease Accounting for Lessee
UPDATE chapters 
SET lecture_duration_minutes = 190 
WHERE chapter_number = 9;

-- Update Chapter 10: Notes Receivable and Payable
UPDATE chapters 
SET lecture_duration_minutes = 169 
WHERE chapter_number = 10;

-- Update Chapter 11: Revenue from Contracts with Customers
UPDATE chapters 
SET lecture_duration_minutes = 413 
WHERE chapter_number = 11;

-- Update Chapter 12: Equity Transactions and Earnings Per Share
UPDATE chapters 
SET lecture_duration_minutes = 268 
WHERE chapter_number = 12;