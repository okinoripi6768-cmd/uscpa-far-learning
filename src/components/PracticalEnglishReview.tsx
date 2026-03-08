import React, { useState, useEffect } from 'react';
import { X, RotateCw, ChevronLeft, ChevronRight, BookOpen, AlertCircle } from 'lucide-react';
import {
  getPracticalEnglishFlashcardsByChapter,
  updatePracticalEnglishProgress,
  getPracticalEnglishStats,
  PracticalEnglishFlashcardWithProgress
} from '../lib/practicalEnglishService';

interface PracticalEnglishReviewProps {
  chapterId: string;
  onClose: () => void;
}

export function PracticalEnglishReview({ chapterId, onClose }: PracticalEnglishReviewProps) {
  const [flashcards, setFlashcards] = useState<PracticalEnglishFlashcardWithProgress[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isFlipped, setIsFlipped] = useState(false);
  const [loading, setLoading] = useState(true);
  const [stats, setStats] = useState({ total: 0, notStarted: 0, practicing: 0, confident: 0, completionRate: 0 });

  useEffect(() => {
    loadFlashcards();
  }, [chapterId]);

  const loadFlashcards = async () => {
    try {
      setLoading(true);
      const [cards, statsData] = await Promise.all([
        getPracticalEnglishFlashcardsByChapter(chapterId),
        getPracticalEnglishStats(chapterId)
      ]);
      setFlashcards(cards);
      setStats(statsData);
    } catch (error) {
      console.error('Failed to load practical English flashcards:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleStatusUpdate = async (status: 'practicing' | 'confident') => {
    try {
      const currentCard = flashcards[currentIndex];
      await updatePracticalEnglishProgress(currentCard.id, status);
      await loadFlashcards();

      if (currentIndex < flashcards.length - 1) {
        setCurrentIndex(currentIndex + 1);
        setIsFlipped(false);
      }
    } catch (error) {
      console.error('Failed to update progress:', error);
    }
  };

  const goToNext = () => {
    if (currentIndex < flashcards.length - 1) {
      setCurrentIndex(currentIndex + 1);
      setIsFlipped(false);
    }
  };

  const goToPrevious = () => {
    if (currentIndex > 0) {
      setCurrentIndex(currentIndex - 1);
      setIsFlipped(false);
    }
  };

  if (loading) {
    return (
      <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
        <div className="bg-white rounded-xl p-8">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
        </div>
      </div>
    );
  }

  if (flashcards.length === 0) {
    return (
      <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
        <div className="bg-white rounded-xl p-8 max-w-md">
          <div className="text-center">
            <AlertCircle className="w-16 h-16 text-gray-400 mx-auto mb-4" />
            <h3 className="text-xl font-semibold mb-2">No Flashcards Available</h3>
            <p className="text-gray-600 mb-6">
              There are no practical English flashcards for this chapter yet.
            </p>
            <button
              onClick={onClose}
              className="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
            >
              Close
            </button>
          </div>
        </div>
      </div>
    );
  }

  const currentCard = flashcards[currentIndex];
  const currentStatus = currentCard.progress?.status || 'not_started';

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-3 sm:p-4 overflow-y-auto">
      <div className="bg-white rounded-xl shadow-2xl w-full max-w-4xl my-auto max-h-[95vh] sm:max-h-[90vh] flex flex-col">
        <div className="p-4 sm:p-6 border-b border-gray-200 flex items-center justify-between flex-shrink-0 bg-white">
          <div className="flex items-center gap-2 sm:gap-3">
            <BookOpen className="w-5 h-5 sm:w-6 sm:h-6 text-blue-600" />
            <div>
              <h2 className="text-lg sm:text-2xl font-bold text-gray-900">
                Practical Accounting English
              </h2>
              <p className="text-xs sm:text-sm text-gray-500">Instant Translation Practice</p>
            </div>
          </div>
          <button
            onClick={onClose}
            className="p-2 hover:bg-gray-100 rounded-lg transition-colors touch-manipulation"
          >
            <X className="w-5 h-5 sm:w-6 sm:h-6" />
          </button>
        </div>

        <div className="p-4 sm:p-6 space-y-4 sm:space-y-6 overflow-y-auto flex-1">
          <div className="bg-blue-50 border border-blue-200 rounded-lg p-3 sm:p-4">
            <div className="grid grid-cols-4 gap-2 sm:gap-4 text-center">
              <div>
                <div className="text-lg sm:text-2xl font-bold text-blue-600">{stats.total}</div>
                <div className="text-xs text-gray-600">Total</div>
              </div>
              <div>
                <div className="text-lg sm:text-2xl font-bold text-gray-400">{stats.notStarted}</div>
                <div className="text-xs text-gray-600">Not Started</div>
              </div>
              <div>
                <div className="text-lg sm:text-2xl font-bold text-yellow-600">{stats.practicing}</div>
                <div className="text-xs text-gray-600">Practicing</div>
              </div>
              <div>
                <div className="text-lg sm:text-2xl font-bold text-green-600">{stats.confident}</div>
                <div className="text-xs text-gray-600">Confident</div>
              </div>
            </div>
          </div>

          <div className="flex items-center justify-between text-xs sm:text-sm text-gray-600">
            <span>Card {currentIndex + 1} of {flashcards.length}</span>
            <span className="px-2 sm:px-3 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-700">
              {currentCard.topic}
            </span>
          </div>

          <div
            className={`relative min-h-[250px] sm:min-h-[300px] cursor-pointer perspective-1000 touch-manipulation`}
            onClick={() => setIsFlipped(!isFlipped)}
          >
            <div
              className={`relative w-full transition-transform duration-500 transform-style-3d ${
                isFlipped ? 'rotate-y-180' : ''
              }`}
            >
              <div
                className={`bg-gradient-to-br from-blue-50 to-white border-2 border-blue-200 rounded-xl p-8 shadow-lg ${
                  isFlipped ? 'hidden' : 'block'
                }`}
              >
                <div className="text-center">
                  <div className="inline-block px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-full mb-6">
                    日本語プロンプト
                  </div>
                  <p className="text-2xl font-medium text-gray-900 leading-relaxed">
                    {currentCard.japanese_prompt}
                  </p>
                  <div className="mt-8 text-sm text-gray-500 flex items-center justify-center gap-2">
                    <RotateCw className="w-4 h-4" />
                    Click to see English answer
                  </div>
                </div>
              </div>

              <div
                className={`bg-gradient-to-br from-green-50 to-white border-2 border-green-200 rounded-xl p-8 shadow-lg ${
                  isFlipped ? 'block' : 'hidden'
                }`}
              >
                <div>
                  <div className="inline-block px-4 py-2 bg-green-600 text-white text-sm font-medium rounded-full mb-6">
                    Model English Answer
                  </div>
                  <p className="text-lg text-gray-800 leading-relaxed mb-6 whitespace-pre-wrap">
                    {currentCard.english_answer}
                  </p>
                  <div className="mt-6 p-4 bg-gray-50 rounded-lg border border-gray-200">
                    <div className="text-sm font-semibold text-gray-700 mb-2">Key Phrases:</div>
                    <p className="text-sm text-gray-600 italic">
                      {currentCard.key_phrases}
                    </p>
                  </div>
                  <div className="mt-8 text-sm text-gray-500 flex items-center justify-center gap-2">
                    <RotateCw className="w-4 h-4" />
                    Click to see Japanese prompt
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div className="flex items-center justify-center gap-4 pt-4">
            <button
              onClick={goToPrevious}
              disabled={currentIndex === 0}
              className="p-3 rounded-lg border-2 border-gray-300 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
            >
              <ChevronLeft className="w-5 h-5" />
            </button>

            <div className="flex gap-3">
              <button
                onClick={() => handleStatusUpdate('practicing')}
                className={`px-6 py-3 rounded-lg font-medium transition-colors ${
                  currentStatus === 'practicing'
                    ? 'bg-yellow-600 text-white'
                    : 'bg-yellow-100 text-yellow-700 hover:bg-yellow-200'
                }`}
              >
                Still Practicing
              </button>
              <button
                onClick={() => handleStatusUpdate('confident')}
                className={`px-6 py-3 rounded-lg font-medium transition-colors ${
                  currentStatus === 'confident'
                    ? 'bg-green-600 text-white'
                    : 'bg-green-100 text-green-700 hover:bg-green-200'
                }`}
              >
                Confident
              </button>
            </div>

            <button
              onClick={goToNext}
              disabled={currentIndex === flashcards.length - 1}
              className="p-3 rounded-lg border-2 border-gray-300 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
            >
              <ChevronRight className="w-5 h-5" />
            </button>
          </div>

          <div className="bg-amber-50 border border-amber-200 rounded-lg p-4">
            <div className="flex items-start gap-3">
              <AlertCircle className="w-5 h-5 text-amber-600 mt-0.5 flex-shrink-0" />
              <div className="text-sm text-gray-700">
                <p className="font-medium mb-1">Purpose of this section:</p>
                <p>
                  This is NOT a test of accounting correctness. Focus on expressing
                  accounting judgments professionally in English, suitable for audit
                  discussions, M&A due diligence, and cross-border reporting scenarios.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
