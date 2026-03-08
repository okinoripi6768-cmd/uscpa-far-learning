/*
  # Add Chapter 1 Instant Translation Flashcards

  ## Summary
  Adds instant translation practice flashcards for Chapter 1: Conceptual Framework
  
  ## Topics Covered
  - Asset recognition
  - Revenue recognition
  - Liabilities
  - Equity
  - Expenses
  - Going concern

  ## Format
  Each flashcard contains:
  - Short Japanese sentence
  - Target English translation
  - Difficulty level
  - Keywords for reference
*/

-- Get Chapter 1 ID
DO $$
DECLARE
  v_chapter1_id uuid;
BEGIN
  SELECT id INTO v_chapter1_id FROM chapters WHERE chapter_number = 1;

  -- Flashcard 1: Asset Recognition
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter1_id,
    'Asset Recognition',
    '資産は、過去の事象の結果として企業が支配し、将来の経済的便益が期待される資源である。',
    'An asset is a resource controlled by the entity as a result of past events from which future economic benefits are expected to flow.',
    'basic',
    'asset, resource, controlled, past events, future economic benefits',
    1
  );

  -- Flashcard 2: Revenue Recognition
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter1_id,
    'Revenue Recognition',
    '収益は、資産の増加または負債の減少による持分の増加として認識される。',
    'Revenue is recognized as an increase in equity resulting from an increase in assets or a decrease in liabilities.',
    'intermediate',
    'revenue, increase, equity, assets, liabilities',
    2
  );

  -- Flashcard 3: Liabilities
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter1_id,
    'Liabilities',
    '負債は、過去の事象から生じた現在の義務である。',
    'A liability is a present obligation arising from past events.',
    'basic',
    'liability, present obligation, past events',
    3
  );

  -- Flashcard 4: Equity
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter1_id,
    'Equity',
    '持分は、資産から負債を差し引いた残余持分である。',
    'Equity is the residual interest in assets after deducting liabilities.',
    'basic',
    'equity, residual interest, assets, deducting, liabilities',
    4
  );

  -- Flashcard 5: Expenses
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter1_id,
    'Expenses',
    '費用は、資産の減少または負債の増加による持分の減少である。',
    'Expenses are decreases in equity resulting from a decrease in assets or an increase in liabilities.',
    'intermediate',
    'expenses, decrease, equity, assets, liabilities',
    5
  );

  -- Flashcard 6: Going Concern
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter1_id,
    'Going Concern',
    '継続企業の前提では、企業は予見可能な将来にわたって事業を継続する。',
    'Under the going concern assumption, an entity is expected to continue operations for the foreseeable future.',
    'intermediate',
    'going concern, assumption, continue operations, foreseeable future',
    6
  );

  -- Flashcard 7: Materiality
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter1_id,
    'Materiality',
    '重要性とは、情報の省略や誤表示が利用者の意思決定に影響を与える可能性がある程度である。',
    'Materiality is the magnitude at which omissions or misstatements could influence the economic decisions of users.',
    'advanced',
    'materiality, magnitude, omissions, misstatements, influence, economic decisions',
    7
  );
END $$;
