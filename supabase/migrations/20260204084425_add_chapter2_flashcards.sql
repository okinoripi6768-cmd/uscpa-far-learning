/*
  # Add Chapter 2 Flashcards - Presentation / Disclosure / Recognition

  1. Data Insertion
    - Adds 15 flashcard terms for Chapter 2
    - Covers presentation, disclosure, and recognition concepts
    - Includes common misconceptions and instant recognition phrases

  2. Flashcards Added
    1. presentation - 財務諸表への表示方法
    2. disclosure - 注記による開示
    3. recognition - 財務諸表に計上すること
    4. measurement - 測定（いくらで計上するか）
    5. realize vs recognize - 実現 vs 計上
    6. material misstatement - 重要な虚偽表示
    7. comparative financial statements - 比較財務諸表
    8. classified balance sheet - 分類貸借対照表
    9. subsequent events - 後発事象
    10. accounting policy - 会計方針
    11. prior period adjustment - 前期修正
    12. estimate vs error - 見積 vs 誤り
    13. going concern disclosure - 継続企業に関する開示
    14. interim reporting - 中間財務報告
    15. full disclosure principle - 完全開示の原則
*/

-- Insert Chapter 2 flashcards
INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index) VALUES
(
  '1e386538-2d44-4e30-b498-2205bb0da29f',
  'presentation',
  '財務諸表への表示方法',
  '表（FS）に載せるかどうか
配置・分類の話',
  '× disclosure と同義',
  'presented on the face of FS',
  1
),
(
  '1e386538-2d44-4e30-b498-2205bb0da29f',
  'disclosure',
  '注記による開示',
  'notes に書く
数値は動かさない',
  '× 財務諸表に計上',
  'disclosed in the notes',
  2
),
(
  '1e386538-2d44-4e30-b498-2205bb0da29f',
  'recognition',
  '財務諸表に計上すること',
  'P/L or B/S に数字を載せる',
  '× 単なる開示',
  'recognized → recorded',
  3
),
(
  '1e386538-2d44-4e30-b498-2205bb0da29f',
  'measurement',
  '測定（いくらで計上するか）',
  'cost / FV / NRV など',
  '× 認識タイミングの話',
  'measured at…',
  4
),
(
  '1e386538-2d44-4e30-b498-2205bb0da29f',
  'realize vs recognize',
  'realize：実現（取引発生）
recognize：計上',
  'realize ≠ recognize',
  '× 同じ意味',
  'realized but not recognized',
  5
),
(
  '1e386538-2d44-4e30-b498-2205bb0da29f',
  'material misstatement',
  '重要な虚偽表示',
  '監査論点にも接続
materiality 判断',
  '× 単なるミス',
  'could affect users'' decisions',
  6
),
(
  '1e386538-2d44-4e30-b498-2205bb0da29f',
  'comparative financial statements',
  '比較財務諸表',
  '複数期間の表示
一貫性が重要',
  '× 単年度のみ',
  'comparative periods',
  7
),
(
  '1e386538-2d44-4e30-b498-2205bb0da29f',
  'classified balance sheet',
  '分類貸借対照表',
  'current / noncurrent',
  '× 順番が重要',
  'current vs noncurrent',
  8
),
(
  '1e386538-2d44-4e30-b498-2205bb0da29f',
  'subsequent events',
  '後発事象',
  'recognized vs nonrecognized',
  '× すべて修正',
  'provides additional evidence → adjust',
  9
),
(
  '1e386538-2d44-4e30-b498-2205bb0da29f',
  'accounting policy',
  '会計方針',
  '変更時は開示',
  '× 会計基準そのもの',
  'change → disclose',
  10
),
(
  '1e386538-2d44-4e30-b498-2205bb0da29f',
  'prior period adjustment',
  '前期修正',
  'error correction
retained earnings 修正',
  '× 見積変更',
  'error → restate',
  11
),
(
  '1e386538-2d44-4e30-b498-2205bb0da29f',
  'estimate vs error',
  'estimate：将来予測
error：誤り',
  'estimate → prospective
error → retrospective',
  '× どちらも修正',
  'change in estimate → future only',
  12
),
(
  '1e386538-2d44-4e30-b498-2205bb0da29f',
  'going concern disclosure',
  '継続企業に関する開示',
  '認識ではなく開示',
  '× 資産を減額',
  'substantial doubt → disclose',
  13
),
(
  '1e386538-2d44-4e30-b498-2205bb0da29f',
  'interim reporting',
  '中間財務報告',
  '見積りの使用増加',
  '× 年次と同じ精度',
  'interim → estimates',
  14
),
(
  '1e386538-2d44-4e30-b498-2205bb0da29f',
  'full disclosure principle',
  '完全開示の原則',
  '利害関係者に重要情報を提供',
  '× すべて開示',
  'material information only',
  15
);