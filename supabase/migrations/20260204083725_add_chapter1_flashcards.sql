/*
  # Add Chapter 1 Flashcards

  1. Data Insertion
    - Adds 10 flashcard terms for Chapter 1
    - Covers fundamental accounting concepts
    - Includes common misconceptions and instant recognition phrases

  2. Flashcards Added
    1. accrual basis - 発生主義会計
    2. going concern - 継続企業の前提
    3. historical cost - 取得原価
    4. matching principle - 収益・費用対応の原則
    5. relevance / faithful representation - 意思決定有用性 / 忠実な表現
    6. materiality - 重要性
    7. conservatism (prudence) - 保守主義
    8. economic entity assumption - 経済主体の前提
    9. reporting period - 会計期間
    10. consistency - 継続性
*/

-- Insert Chapter 1 flashcards
INSERT INTO flashcards (chapter_id, term, meaning, far_point, misconception, instant_phrase, order_index) VALUES
(
  '1a6129ac-6200-43d8-88fe-8a202e1bf75e',
  'accrual basis',
  '発生主義会計',
  'cash basis ではない
収益・費用は発生時に認識',
  '× 現金の入出金基準',
  'earned / incurred → record',
  1
),
(
  '1a6129ac-6200-43d8-88fe-8a202e1bf75e',
  'going concern',
  '継続企業の前提',
  'liquidation 前提ではない
開示論点に直結',
  '× 永遠に続くという意味',
  'doubt exists → disclosure',
  2
),
(
  '1a6129ac-6200-43d8-88fe-8a202e1bf75e',
  'historical cost',
  '取得原価',
  'fair value が出るまでは基本これ',
  '× 常に時価評価',
  'at cost → no remeasurement',
  3
),
(
  '1a6129ac-6200-43d8-88fe-8a202e1bf75e',
  'matching principle',
  '収益・費用対応の原則',
  'revenue に関連する費用を同期間で認識',
  '× キャッシュの対応',
  'related revenue → same period expense',
  4
),
(
  '1a6129ac-6200-43d8-88fe-8a202e1bf75e',
  'relevance / faithful representation',
  '意思決定有用性 / 忠実な表現',
  'conceptual framework',
  '× 完璧・正確であること',
  'useful to users',
  5
),
(
  '1a6129ac-6200-43d8-88fe-8a202e1bf75e',
  'materiality',
  '重要性',
  '金額ではなく影響度',
  '× 小さい金額＝immaterial',
  'could influence decision',
  6
),
(
  '1a6129ac-6200-43d8-88fe-8a202e1bf75e',
  'conservatism (prudence)',
  '保守主義',
  '損失は早く、利益は慎重に',
  '× 利益を操作する原則',
  'anticipate losses, not gains',
  7
),
(
  '1a6129ac-6200-43d8-88fe-8a202e1bf75e',
  'economic entity assumption',
  '経済主体の前提',
  '会社とオーナーは別',
  '× 連結会計の話',
  'separate from owner',
  8
),
(
  '1a6129ac-6200-43d8-88fe-8a202e1bf75e',
  'reporting period',
  '会計期間',
  'annual / interim reporting',
  '× 1年固定',
  'interim → estimates increase',
  9
),
(
  '1a6129ac-6200-43d8-88fe-8a202e1bf75e',
  'consistency',
  '継続性',
  '会計方針変更 → 開示',
  '× 変更禁止',
  'change → disclose',
  10
);