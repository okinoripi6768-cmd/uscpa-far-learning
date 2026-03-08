/*
  # Add Chapter 3 Instant Translation Flashcards

  ## Summary
  Adds instant translation practice flashcards for Chapter 3: Cash and Receivables
  
  ## Topics Covered
  - Cash equivalents
  - Bank reconciliation
  - Accounts receivable
  - Allowance for doubtful accounts
  - Factoring
  - Impairment

  ## Format
  Each flashcard contains:
  - Short Japanese sentence
  - Target English translation
  - Difficulty level
  - Keywords for reference
*/

-- Get Chapter 3 ID
DO $$
DECLARE
  v_chapter3_id uuid;
BEGIN
  SELECT id INTO v_chapter3_id FROM chapters WHERE chapter_number = 3;

  -- Flashcard 1: Cash Equivalents
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter3_id,
    'Cash Equivalents',
    '現金同等物は、容易に一定の金額の現金に換金可能な短期投資である。',
    'Cash equivalents are short-term, highly liquid investments that are readily convertible to known amounts of cash.',
    'intermediate',
    'cash equivalents, short-term, highly liquid, readily convertible',
    1
  );

  -- Flashcard 2: Bank Reconciliation
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter3_id,
    'Bank Reconciliation',
    '銀行勘定調整表は、帳簿残高と銀行残高の差異を調整する。',
    'A bank reconciliation reconciles the differences between the book balance and the bank balance.',
    'basic',
    'bank reconciliation, reconciles, differences, book balance, bank balance',
    2
  );

  -- Flashcard 3: Accounts Receivable
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter3_id,
    'Accounts Receivable',
    '売掛金は、顧客に対する債権であり、通常の営業活動から発生する。',
    'Accounts receivable are amounts owed by customers arising from normal business operations.',
    'basic',
    'accounts receivable, amounts owed, customers, normal business operations',
    3
  );

  -- Flashcard 4: Allowance Method
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter3_id,
    'Allowance',
    '貸倒引当金は、回収不能と見込まれる売掛金の金額を見積もる。',
    'The allowance for doubtful accounts estimates the amount of receivables that are not expected to be collected.',
    'intermediate',
    'allowance for doubtful accounts, estimates, receivables, not expected to be collected',
    4
  );

  -- Flashcard 5: Factoring
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter3_id,
    'Factoring',
    '売掛金の売却では、リスクと便益が譲渡されたかどうかを判断する。',
    'In factoring receivables, it must be determined whether risks and rewards have been transferred.',
    'advanced',
    'factoring, receivables, determined, risks and rewards, transferred',
    5
  );

  -- Flashcard 6: Impairment
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter3_id,
    'Impairment',
    '金融資産の減損は、予想信用損失モデルに基づいて測定される。',
    'Impairment of financial assets is measured based on the expected credit loss model.',
    'advanced',
    'impairment, financial assets, measured, expected credit loss model',
    6
  );

  -- Flashcard 7: Net Realizable Value
  INSERT INTO instant_translation_flashcards 
    (chapter_id, topic, japanese_sentence, english_translation, difficulty, keywords, order_index)
  VALUES (
    v_chapter3_id,
    'Valuation',
    '売掛金は、正味実現可能価額で測定される。',
    'Receivables are measured at net realizable value.',
    'basic',
    'receivables, measured, net realizable value',
    7
  );
END $$;
