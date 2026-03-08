/*
  # Add Chapter 2 Practical Accounting English Flashcards

  ## Summary
  Adds practical English flashcards for Chapter 2: Financial Statements
  
  ## Topics Covered
  - Classification issues
  - Disclosure requirements
  - Presentation judgment
  - Comparative information
  - Error corrections

  ## Format
  Each flashcard contains:
  - Japanese prompt (front)
  - Model English answer with reasoning phrases (back)
  - Key phrases for reference
*/

-- Get Chapter 2 ID
DO $$
DECLARE
  v_chapter2_id uuid;
BEGIN
  SELECT id INTO v_chapter2_id FROM chapters WHERE chapter_number = 2;

  -- Flashcard 1: Classification
  INSERT INTO practical_english_flashcards 
    (chapter_id, topic, japanese_prompt, english_answer, key_phrases, order_index)
  VALUES (
    v_chapter2_id,
    'Classification',
    'この負債を流動負債と非流動負債のどちらに分類すべきか、議論が必要です。',
    'The classification of this liability requires careful consideration of the facts and circumstances. From an accounting perspective, the key factor is whether the entity has an unconditional right to defer settlement for at least twelve months after the reporting period. This involves judgment regarding the substance of the arrangement. Based on our current understanding, we are analyzing the contractual terms to determine the appropriate presentation.',
    'requires careful consideration, from an accounting perspective, involves judgment, based on our current understanding',
    1
  );

  -- Flashcard 2: Disclosure Adequacy
  INSERT INTO practical_english_flashcards 
    (chapter_id, topic, japanese_prompt, english_answer, key_phrases, order_index)
  VALUES (
    v_chapter2_id,
    'Disclosure',
    '開示が十分かどうか、追加の情報が必要か判断したい。',
    'We need to assess whether the current disclosures are adequate for users to understand the financial impact. From a disclosure perspective, the key consideration is whether the information provided is both relevant and reliable. This requires judgment about what a reasonable user would need to make informed decisions. At this stage, we recommend enhancing certain disclosures to provide better context around the significant accounting policies applied.',
    'assess whether, from a disclosure perspective, key consideration, requires judgment, at this stage, recommend enhancing',
    2
  );

  -- Flashcard 3: Comparative Information
  INSERT INTO practical_english_flashcards 
    (chapter_id, topic, japanese_prompt, english_answer, key_phrases, order_index)
  VALUES (
    v_chapter2_id,
    'Comparative Information',
    '前年度の数値を修正再表示すべきかどうか、検討が必要です。',
    'The need for restatement of comparative information depends on the nature and materiality of the identified issue. From a technical standpoint, we need to determine whether this represents an error or a change in estimate. The key consideration is whether the prior period information is materially misstated. Based on our preliminary analysis, we are evaluating whether retrospective application is required under the applicable standards.',
    'depends on the nature and materiality, from a technical standpoint, key consideration, based on our preliminary analysis',
    3
  );

  -- Flashcard 4: Presentation Format
  INSERT INTO practical_english_flashcards 
    (chapter_id, topic, japanese_prompt, english_answer, key_phrases, order_index)
  VALUES (
    v_chapter2_id,
    'Presentation',
    '財務諸表の表示形式について、クライアントと調整したい。',
    'The presentation format should reflect the substance of the underlying transactions and provide useful information to users. From a practical perspective, the key consideration is balancing compliance with standards and the need for clarity. This requires judgment about what presentation best serves the needs of the primary users. Based on industry practice and the specific circumstances, we suggest discussing alternative presentation approaches with the stakeholders.',
    'should reflect the substance, from a practical perspective, requires judgment, based on industry practice',
    4
  );

  -- Flashcard 5: Subsequent Events
  INSERT INTO practical_english_flashcards 
    (chapter_id, topic, japanese_prompt, english_answer, key_phrases, order_index)
  VALUES (
    v_chapter2_id,
    'Subsequent Events',
    '期末後の事象が財務諸表に与える影響を評価する必要があります。',
    'We need to evaluate whether this subsequent event requires adjustment or disclosure in the financial statements. From an assessment perspective, the key consideration is whether the event provides evidence of conditions that existed at the balance sheet date. This requires judgment regarding the timing and nature of the event. At this stage, we are gathering information to determine the appropriate accounting treatment and whether additional disclosure is necessary.',
    'evaluate whether, from an assessment perspective, key consideration, requires judgment, at this stage',
    5
  );
END $$;
