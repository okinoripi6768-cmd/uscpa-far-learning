/*
  # Add Chapter 1 Practical Accounting English Flashcards

  ## Summary
  Adds practical English flashcards for Chapter 1: Conceptual Framework
  
  ## Topics Covered
  - Asset recognition criteria
  - Revenue recognition judgment
  - Estimate and assumptions
  - Materiality assessment
  - Going concern considerations

  ## Format
  Each flashcard contains:
  - Japanese prompt (front)
  - Model English answer with reasoning phrases (back)
  - Key phrases for reference
*/

-- Get Chapter 1 ID
DO $$
DECLARE
  v_chapter1_id uuid;
BEGIN
  SELECT id INTO v_chapter1_id FROM chapters WHERE chapter_number = 1;

  -- Flashcard 1: Asset Recognition
  INSERT INTO practical_english_flashcards 
    (chapter_id, topic, japanese_prompt, english_answer, key_phrases, order_index)
  VALUES (
    v_chapter1_id,
    'Asset Recognition',
    'この支出が資産として認識できるかどうか、監査チームに説明してください。',
    'From an accounting perspective, we need to evaluate whether this expenditure meets the recognition criteria for an asset. The key consideration is whether it provides probable future economic benefits and can be reliably measured. Based on our assessment of the facts and circumstances, this requires judgment regarding the nature and timing of those benefits. At this stage, we believe further documentation is needed to support the capitalization decision.',
    'from an accounting perspective, key consideration, based on our assessment, requires judgment, at this stage',
    1
  );

  -- Flashcard 2: Revenue Recognition Timing
  INSERT INTO practical_english_flashcards 
    (chapter_id, topic, japanese_prompt, english_answer, key_phrases, order_index)
  VALUES (
    v_chapter1_id,
    'Revenue Recognition',
    '収益認識のタイミングについて、現状の判断を英語で伝えてください。',
    'The timing of revenue recognition in this case involves significant judgment. From a technical standpoint, we need to determine when control transfers to the customer. The key consideration is whether the performance obligation has been satisfied at a point in time or over time. Based on the contract terms and our preliminary analysis, we are currently evaluating the appropriate recognition pattern.',
    'involves significant judgment, from a technical standpoint, key consideration, based on the contract terms, currently evaluating',
    2
  );

  -- Flashcard 3: Estimates and Assumptions
  INSERT INTO practical_english_flashcards 
    (chapter_id, topic, japanese_prompt, english_answer, key_phrases, order_index)
  VALUES (
    v_chapter1_id,
    'Estimates',
    '見積もりの妥当性について、クライアントに慎重に確認する必要があります。',
    'We need to carefully assess the reasonableness of the estimates used. From an auditing perspective, the key consideration is whether the assumptions are appropriate given the current market conditions. This requires judgment and may involve engaging specialists. Based on our preliminary review, we recommend documenting the basis for these estimates more thoroughly to support their reliability.',
    'carefully assess, from an auditing perspective, key consideration, requires judgment, based on our preliminary review',
    3
  );

  -- Flashcard 4: Materiality
  INSERT INTO practical_english_flashcards 
    (chapter_id, topic, japanese_prompt, english_answer, key_phrases, order_index)
  VALUES (
    v_chapter1_id,
    'Materiality',
    'この項目が重要性のあるものかどうか、判断基準を説明してください。',
    'The determination of materiality involves both quantitative and qualitative factors. From a professional judgment standpoint, we need to consider whether this item could influence the economic decisions of users. The key consideration is not just the dollar amount but also the nature of the item and its context. Based on our materiality framework, we are evaluating this matter in consultation with the engagement team.',
    'involves both quantitative and qualitative factors, from a professional judgment standpoint, key consideration, based on our materiality framework',
    4
  );

  -- Flashcard 5: Going Concern
  INSERT INTO practical_english_flashcards 
    (chapter_id, topic, japanese_prompt, english_answer, key_phrases, order_index)
  VALUES (
    v_chapter1_id,
    'Going Concern',
    '継続企業の前提について、現在の懸念事項を伝えたい。',
    'We have identified certain conditions that may raise questions about the going concern assumption. From a risk assessment perspective, the key consideration is whether there are material uncertainties that cast significant doubt on the entity''s ability to continue as a going concern. This requires careful judgment and analysis of both current liquidity and forecasted cash flows. At this stage, we are gathering additional evidence to support our conclusion.',
    'from a risk assessment perspective, key consideration, requires careful judgment, at this stage, gathering additional evidence',
    5
  );
END $$;
