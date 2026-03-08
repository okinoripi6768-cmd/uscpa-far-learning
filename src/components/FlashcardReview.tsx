import { useState, useEffect } from 'react';
import { X, ChevronLeft, ChevronRight, RotateCw, BookOpen } from 'lucide-react';
import { FlashcardWithProgress, updateFlashcardProgress, getDailyFlashcards, getFlashcardStats } from '../lib/flashcardService';

interface FlashcardReviewProps {
  selectedChapterIds: string[];
  onClose: () => void;
}

export function FlashcardReview({ selectedChapterIds, onClose }: FlashcardReviewProps) {
  const [flashcards, setFlashcards] = useState<FlashcardWithProgress[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isFlipped, setIsFlipped] = useState(false);
  const [loading, setLoading] = useState(true);
  const [stats, setStats] = useState({ total: 0, notStarted: 0, reviewing: 0, mastered: 0 });

  useEffect(() => {
    loadFlashcards();
  }, [selectedChapterIds]);

  const loadFlashcards = async () => {
    try {
      setLoading(true);
      const [cards, statistics] = await Promise.all([
        getDailyFlashcards(selectedChapterIds),
        getFlashcardStats(selectedChapterIds)
      ]);
      setFlashcards(cards);
      setStats(statistics);
      setCurrentIndex(0);
      setIsFlipped(false);
    } catch (error) {
      console.error('Failed to load flashcards:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleStatusUpdate = async (status: 'not_started' | 'reviewing' | 'mastered', e: React.MouseEvent) => {
    e.stopPropagation();
    console.log('handleStatusUpdate called with status:', status);

    if (!flashcards[currentIndex]) {
      console.error('No flashcard at current index:', currentIndex);
      return;
    }

    try {
      const currentCard = flashcards[currentIndex];
      console.log('Current card:', currentCard);
      const oldStatus = currentCard.progress?.status || 'not_started';
      console.log('Old status:', oldStatus, 'New status:', status);

      await updateFlashcardProgress(currentCard.id, status);
      console.log('Successfully updated progress in database');

      const updatedFlashcards = [...flashcards];
      updatedFlashcards[currentIndex] = {
        ...updatedFlashcards[currentIndex],
        progress: {
          ...updatedFlashcards[currentIndex].progress!,
          status,
          review_count: (updatedFlashcards[currentIndex].progress?.review_count || 0) + 1
        }
      };
      setFlashcards(updatedFlashcards);
      console.log('Updated local flashcard state');

      setStats(prev => {
        const newStats = { ...prev };
        if (oldStatus === 'not_started') newStats.notStarted--;
        else if (oldStatus === 'reviewing') newStats.reviewing--;
        else if (oldStatus === 'mastered') newStats.mastered--;

        if (status === 'not_started') newStats.notStarted++;
        else if (status === 'reviewing') newStats.reviewing++;
        else if (status === 'mastered') newStats.mastered++;

        console.log('Updated stats:', newStats);
        return newStats;
      });

      console.log('Current index:', currentIndex, 'Total flashcards:', flashcards.length);
      if (currentIndex < flashcards.length - 1) {
        console.log('Moving to next card');
        setCurrentIndex(currentIndex + 1);
        setIsFlipped(false);
      } else {
        console.log('Last card reached, reloading flashcards');
        await loadFlashcards();
      }
    } catch (error) {
      console.error('Failed to update flashcard progress:', error);
      alert('Failed to update flashcard progress. Check console for details.');
    }
  };

  const goToNext = (e: React.MouseEvent) => {
    e.stopPropagation();
    if (currentIndex < flashcards.length - 1) {
      setCurrentIndex(currentIndex + 1);
      setIsFlipped(false);
    }
  };

  const goToPrevious = (e: React.MouseEvent) => {
    e.stopPropagation();
    if (currentIndex > 0) {
      setCurrentIndex(currentIndex - 1);
      setIsFlipped(false);
    }
  };

  if (loading) {
    return (
      <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
        <div className="bg-white rounded-lg p-8">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-4 text-gray-600">Loading flashcards...</p>
        </div>
      </div>
    );
  }

  if (flashcards.length === 0) {
    return (
      <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
        <div className="bg-white rounded-lg p-8 max-w-md">
          <div className="text-center">
            <BookOpen className="w-16 h-16 text-gray-400 mx-auto mb-4" />
            <h3 className="text-xl font-semibold mb-2">No flashcards available</h3>
            <p className="text-gray-600 mb-6">
              {selectedChapterIds.length === 0
                ? 'Please select chapters to review flashcards.'
                : 'All flashcards for selected chapters have been mastered!'}
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

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-3 sm:p-4 overflow-y-auto">
      <div className="bg-white rounded-lg shadow-xl max-w-3xl w-full my-auto max-h-[95vh] sm:max-h-[90vh] flex flex-col">
        <div className="p-4 sm:p-6 border-b border-gray-200 flex items-center justify-between flex-shrink-0">
          <div>
            <h2 className="text-xl font-semibold">FAR English Flashcards</h2>
            <p className="text-sm text-gray-600 mt-1">
              Card {currentIndex + 1} of {flashcards.length}
            </p>
          </div>
          <button
            onClick={onClose}
            className="p-2 hover:bg-gray-100 rounded-lg transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="p-4 sm:p-6 overflow-y-auto flex-1">
          <div className="mb-4 sm:mb-6 grid grid-cols-4 gap-2 sm:gap-4 text-center">
            <div className="p-2 sm:p-3 bg-gray-50 rounded-lg">
              <div className="text-lg sm:text-2xl font-bold text-gray-900">{stats.total}</div>
              <div className="text-xs text-gray-600 mt-1">Total</div>
            </div>
            <div className="p-2 sm:p-3 bg-blue-50 rounded-lg">
              <div className="text-lg sm:text-2xl font-bold text-blue-600">{stats.notStarted}</div>
              <div className="text-xs text-gray-600 mt-1">Not Started</div>
            </div>
            <div className="p-2 sm:p-3 bg-yellow-50 rounded-lg">
              <div className="text-lg sm:text-2xl font-bold text-yellow-600">{stats.reviewing}</div>
              <div className="text-xs text-gray-600 mt-1">Reviewing</div>
            </div>
            <div className="p-2 sm:p-3 bg-green-50 rounded-lg">
              <div className="text-lg sm:text-2xl font-bold text-green-600">{stats.mastered}</div>
              <div className="text-xs text-gray-600 mt-1">Mastered</div>
            </div>
          </div>

          <div
            className="relative min-h-[300px] sm:min-h-[400px] cursor-pointer mb-4 sm:mb-6 touch-manipulation"
            onClick={() => setIsFlipped(!isFlipped)}
          >
            {!isFlipped ? (
              <div className="bg-gradient-to-br from-blue-500 to-blue-600 rounded-xl p-6 sm:p-8 flex items-center justify-center min-h-[300px] sm:min-h-[400px] transition-all duration-300">
                <div className="text-center">
                  <div className="text-white text-2xl sm:text-4xl font-bold mb-3 sm:mb-4">{currentCard.term}</div>
                  <div className="text-blue-100 text-sm">タップして裏返す</div>
                </div>
              </div>
            ) : (
              <div className="bg-white border-2 border-gray-200 rounded-xl p-4 sm:p-8 min-h-[300px] sm:min-h-[400px] transition-all duration-300">
                <div className="space-y-4 sm:space-y-6">
                  <div>
                    <h3 className="text-sm font-semibold text-gray-500 mb-2">意味:</h3>
                    <p className="text-lg sm:text-xl font-semibold text-gray-900">{currentCard.meaning}</p>
                  </div>

                  <div>
                    <h3 className="text-sm font-semibold text-gray-500 mb-2">FAR論点スイッチ:</h3>
                    <p className="text-sm sm:text-base text-gray-700 whitespace-pre-line">{currentCard.far_point}</p>
                  </div>

                  <div>
                    <h3 className="text-sm font-semibold text-gray-500 mb-2">誤認識しやすい点:</h3>
                    <p className="text-sm sm:text-base text-red-600 whitespace-pre-line">{currentCard.misconception}</p>
                  </div>

                  <div>
                    <h3 className="text-sm font-semibold text-gray-500 mb-2">即断フレーズ:</h3>
                    <p className="text-sm sm:text-base text-green-600 font-semibold">{currentCard.instant_phrase}</p>
                  </div>
                </div>
              </div>
            )}
          </div>

          <div className="flex items-center justify-between mb-4 sm:mb-6" onClick={(e) => e.stopPropagation()}>
            <button
              onClick={(e) => goToPrevious(e)}
              disabled={currentIndex === 0}
              className="p-2 sm:p-3 rounded-lg border border-gray-300 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed touch-manipulation"
            >
              <ChevronLeft className="w-5 h-5" />
            </button>

            <button
              onClick={(e) => {
                e.stopPropagation();
                setIsFlipped(!isFlipped);
              }}
              className="p-2 sm:p-3 rounded-lg border border-gray-300 hover:bg-gray-50 touch-manipulation"
            >
              <RotateCw className="w-5 h-5" />
            </button>

            <button
              onClick={(e) => goToNext(e)}
              disabled={currentIndex === flashcards.length - 1}
              className="p-2 sm:p-3 rounded-lg border border-gray-300 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed touch-manipulation"
            >
              <ChevronRight className="w-5 h-5" />
            </button>
          </div>

          <div className="border-t border-gray-200 pt-4 sm:pt-6" onClick={(e) => e.stopPropagation()}>
            <p className="text-sm text-gray-600 mb-3 text-center">
              {isFlipped ? '理解度を選択:' : 'カードをタップして答えを確認してください'}
            </p>
            <div className="grid grid-cols-3 gap-2 sm:gap-3">
              <button
                onClick={(e) => handleStatusUpdate('not_started', e)}
                disabled={!isFlipped}
                className="px-3 sm:px-4 py-2 sm:py-3 bg-gray-100 hover:bg-gray-200 text-gray-700 rounded-lg text-sm sm:text-base font-medium transition-colors disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:bg-gray-100 touch-manipulation"
              >
                もう一度
              </button>
              <button
                onClick={(e) => handleStatusUpdate('reviewing', e)}
                disabled={!isFlipped}
                className="px-3 sm:px-4 py-2 sm:py-3 bg-yellow-100 hover:bg-yellow-200 text-yellow-700 rounded-lg text-sm sm:text-base font-medium transition-colors disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:bg-yellow-100 touch-manipulation"
              >
                復習中
              </button>
              <button
                onClick={(e) => handleStatusUpdate('mastered', e)}
                disabled={!isFlipped}
                className="px-3 sm:px-4 py-2 sm:py-3 bg-green-100 hover:bg-green-200 text-green-700 rounded-lg text-sm sm:text-base font-medium transition-colors disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:bg-green-100 touch-manipulation"
              >
                習得済み
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
