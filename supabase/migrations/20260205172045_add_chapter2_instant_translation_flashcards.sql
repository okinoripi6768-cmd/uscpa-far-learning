/*
  # Add Chapter 2 Instant Translation Flashcards

  ## Summary
  Adds instant translation practice flashcards for Chapter 2: Financial Statements
  
  ## Topics Covered
  - Balance sheet
  - Income statement
  - Cash flow statement
  - Retained earnings
  - Comprehensive income
  - Disclosure

  ## Format
  Each flashcard contains:
  - Short Japanese sentence
  - Target English translation
  - Difficulty level
  - Keywords for reference
*/

-- Get Chapter 2 ID
DO $$
DECLARE
  v_chapter2_id uuid;
BEGIN
  SELECT id INTO v_chapter2_id FROM chapters WHERE chapter_number = 2;

  -- Flashcard 1: Balance Sheet
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter2_id,
    'Balance Sheet',
    '貸借対照表は、特定時点における企業の財政状態を表示する。',
    'The balance sheet presents the financial position of an entity at a specific point in time.',
    'basic',
    'balance sheet, presents, financial position, specific point in time',
    1
  );

  -- Flashcard 2: Income Statement
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter2_id,
    'Income Statement',
    '損益計算書は、一定期間の経営成績を報告する。',
    'The income statement reports the results of operations for a period of time.',
    'basic',
    'income statement, reports, results of operations, period of time',
    2
  );

  -- Flashcard 3: Cash Flow Statement
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter2_id,
    'Cash Flow Statement',
    'キャッシュフロー計算書は、営業活動、投資活動、財務活動によるキャッシュフローを表示する。',
    'The cash flow statement presents cash flows from operating, investing, and financing activities.',
    'intermediate',
    'cash flow statement, presents, operating, investing, financing activities',
    3
  );

  -- Flashcard 4: Retained Earnings
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter2_id,
    'Retained Earnings',
    '利益剰余金は、企業が設立以来稼得した利益の累積額である。',
    'Retained earnings represent the cumulative amount of net income earned by the entity since inception.',
    'intermediate',
    'retained earnings, cumulative amount, net income, since inception',
    4
  );

  -- Flashcard 5: Comprehensive Income
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter2_id,
    'Comprehensive Income',
    '包括利益には、当期純利益とその他の包括利益が含まれる。',
    'Comprehensive income includes net income and other comprehensive income.',
    'intermediate',
    'comprehensive income, includes, net income, other comprehensive income',
    5
  );

  -- Flashcard 6: Current vs Non-current
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter2_id,
    'Classification',
    '流動資産は、通常の営業循環内または1年以内に現金化される資産である。',
    'Current assets are assets expected to be converted to cash within the normal operating cycle or one year.',
    'advanced',
    'current assets, converted to cash, operating cycle, one year',
    6
  );

  -- Flashcard 7: Disclosure
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter2_id,
    'Disclosure',
    '注記は、財務諸表の重要な構成要素であり、追加情報を提供する。',
    'Notes are an integral part of the financial statements and provide additional information.',
    'intermediate',
    'notes, integral part, financial statements, additional information',
    7
  );
END $$;
