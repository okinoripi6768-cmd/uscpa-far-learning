import React, { useState, useEffect } from 'react';
import { X, RotateCw, ChevronLeft, ChevronRight, Zap, AlertCircle, Award } from 'lucide-react';
import {
  getInstantTranslationFlashcardsByChapter,
  updateInstantTranslationProgress,
  getInstantTranslationStats,
  InstantTranslationFlashcardWithProgress
} from '../lib/instantTranslationService';

interface InstantTranslationProps {
  chapterId: string;
  onClose: () => void;
}

export function InstantTranslation({ chapterId, onClose }: InstantTranslationProps) {
  const [flashcards, setFlashcards] = useState<InstantTranslationFlashcardWithProgress[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isFlipped, setIsFlipped] = useState(false);
  const [loading, setLoading] = useState(true);
  const [stats, setStats] = useState({ total: 0, notStarted: 0, practicing: 0, mastered: 0, completionRate: 0 });

  useEffect(() => {
    loadFlashcards();
  }, [chapterId]);

  const loadFlashcards = async () => {
    try {
      setLoading(true);
      const [cards, statsData] = await Promise.all([
        getInstantTranslationFlashcardsByChapter(chapterId),
        getInstantTranslationStats(chapterId)
      ]);
      setFlashcards(cards);
      setStats(statsData);
    } catch (error) {
      console.error('Failed to load instant translation flashcards:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleStatusUpdate = async (status: 'practicing' | 'mastered') => {
    try {
      const currentCard = flashcards[currentIndex];
      await updateInstantTranslationProgress(currentCard.id, status);
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

  const getDifficultyColor = (difficulty: string) => {
    switch (difficulty) {
      case 'basic':
        return 'bg-green-100 text-green-700';
      case 'intermediate':
        return 'bg-yellow-100 text-yellow-700';
      case 'advanced':
        return 'bg-red-100 text-red-700';
      default:
        return 'bg-gray-100 text-gray-700';
    }
  };

  const getDifficultyLabel = (difficulty: string) => {
    switch (difficulty) {
      case 'basic':
        return '基礎';
      case 'intermediate':
        return '中級';
      case 'advanced':
        return '上級';
      default:
        return '';
    }
  };

  if (loading) {
    return (
      <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
        <div className="bg-white rounded-xl p-8">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-purple-600 mx-auto"></div>
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
            <h3 className="text-xl font-semibold mb-2">フラッシュカードがありません</h3>
            <p className="text-gray-600 mb-6">
              このチャプターの瞬間英作文フラッシュカードはまだありません。
            </p>
            <button
              onClick={onClose}
              className="px-6 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700"
            >
              閉じる
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
            <Zap className="w-5 h-5 sm:w-6 sm:h-6 text-purple-600" />
            <div>
              <h2 className="text-lg sm:text-2xl font-bold text-gray-900">
                瞬間英作文練習
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
          <div className="bg-purple-50 border border-purple-200 rounded-lg p-3 sm:p-4">
            <div className="grid grid-cols-4 gap-2 sm:gap-4 text-center">
              <div>
                <div className="text-lg sm:text-2xl font-bold text-purple-600">{stats.total}</div>
                <div className="text-xs text-gray-600">総数</div>
              </div>
              <div>
                <div className="text-lg sm:text-2xl font-bold text-gray-400">{stats.notStarted}</div>
                <div className="text-xs text-gray-600">未開始</div>
              </div>
              <div>
                <div className="text-lg sm:text-2xl font-bold text-yellow-600">{stats.practicing}</div>
                <div className="text-xs text-gray-600">練習中</div>
              </div>
              <div>
                <div className="text-lg sm:text-2xl font-bold text-green-600">{stats.mastered}</div>
                <div className="text-xs text-gray-600">習得済</div>
              </div>
            </div>
          </div>

          <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2 text-xs sm:text-sm text-gray-600">
            <span>カード {currentIndex + 1} / {flashcards.length}</span>
            <div className="flex items-center gap-2">
              <span className="px-2 sm:px-3 py-1 rounded-full text-xs font-medium bg-purple-100 text-purple-700">
                {currentCard.topic}
              </span>
              <span className={`px-2 sm:px-3 py-1 rounded-full text-xs font-medium ${getDifficultyColor(currentCard.difficulty)}`}>
                {getDifficultyLabel(currentCard.difficulty)}
              </span>
            </div>
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
                className={`bg-gradient-to-br from-purple-50 to-white border-2 border-purple-200 rounded-xl p-8 shadow-lg ${
                  isFlipped ? 'hidden' : 'block'
                }`}
              >
                <div className="text-center">
                  <div className="inline-block px-4 py-2 bg-purple-600 text-white text-sm font-medium rounded-full mb-6">
                    日本語
                  </div>
                  <p className="text-2xl font-medium text-gray-900 leading-relaxed">
                    {currentCard.japanese_sentence}
                  </p>
                  <div className="mt-8 text-sm text-gray-500 flex items-center justify-center gap-2">
                    <RotateCw className="w-4 h-4" />
                    クリックして英語を表示
                  </div>
                </div>
              </div>

              <div
                className={`bg-gradient-to-br from-blue-50 to-white border-2 border-blue-200 rounded-xl p-8 shadow-lg ${
                  isFlipped ? 'block' : 'hidden'
                }`}
              >
                <div>
                  <div className="inline-block px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-full mb-6">
                    English
                  </div>
                  <p className="text-xl text-gray-800 leading-relaxed mb-6">
                    {currentCard.english_translation}
                  </p>
                  <div className="mt-6 p-4 bg-gray-50 rounded-lg border border-gray-200">
                    <div className="flex items-center gap-2 text-sm font-semibold text-gray-700 mb-2">
                      <Award className="w-4 h-4" />
                      キーワード:
                    </div>
                    <p className="text-sm text-gray-600">
                      {currentCard.keywords}
                    </p>
                  </div>
                  <div className="mt-8 text-sm text-gray-500 flex items-center justify-center gap-2">
                    <RotateCw className="w-4 h-4" />
                    クリックして日本語を表示
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
                練習中
              </button>
              <button
                onClick={() => handleStatusUpdate('mastered')}
                className={`px-6 py-3 rounded-lg font-medium transition-colors ${
                  currentStatus === 'mastered'
                    ? 'bg-green-600 text-white'
                    : 'bg-green-100 text-green-700 hover:bg-green-200'
                }`}
              >
                習得済
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

          <div className="bg-purple-50 border border-purple-200 rounded-lg p-4">
            <div className="flex items-start gap-3">
              <Zap className="w-5 h-5 text-purple-600 mt-0.5 flex-shrink-0" />
              <div className="text-sm text-gray-700">
                <p className="font-medium mb-1">練習のポイント:</p>
                <p>
                  日本語を見てから、英語を思い浮かべてからカードをめくってください。
                  完璧でなくても構いません。何度も繰り返すことで自然に身につきます。
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
