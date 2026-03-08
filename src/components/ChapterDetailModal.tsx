import { useEffect, useState, useCallback } from 'react';
import { X, CheckCircle, XCircle, BookOpen, FileText, AlertCircle } from 'lucide-react';
import { getChapterDetail } from '../lib/progressService';
import type { ChapterDetail } from '../lib/progressService';

interface ChapterDetailModalProps {
  chapterId: string;
  currentRound: number;
  onClose: () => void;
}

export function ChapterDetailModal({ chapterId, currentRound, onClose }: ChapterDetailModalProps) {
  const [chapterDetail, setChapterDetail] = useState<ChapterDetail | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  const loadChapterDetail = useCallback(async () => {
    setIsLoading(true);
    try {
      const detail = await getChapterDetail(chapterId, currentRound);
      setChapterDetail(detail);
    } catch (error) {
      console.error('Error loading chapter detail:', error);
    } finally {
      setIsLoading(false);
    }
  }, [chapterId, currentRound]);

  useEffect(() => {
    loadChapterDetail();
  }, [loadChapterDetail]);

  if (isLoading) {
    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
        <div className="bg-white rounded-lg shadow-xl max-w-4xl w-full p-6">
          <div className="text-center text-gray-600">読み込み中...</div>
        </div>
      </div>
    );
  }

  if (!chapterDetail) {
    return null;
  }

  const mcCompletionRate = chapterDetail.totalMcTasks > 0
    ? (chapterDetail.completedMcTasks / chapterDetail.totalMcTasks) * 100
    : 0;

  const tbsCompletionRate = chapterDetail.totalTbsTasks > 0
    ? (chapterDetail.completedTbsTasks / chapterDetail.totalTbsTasks) * 100
    : 0;

  const totalMcReviews = chapterDetail.lectures.reduce((sum, l) => sum + l.mcPendingReview, 0);
  const totalTbsReviews = chapterDetail.lectures.reduce((sum, l) => sum + l.tbsPendingReview, 0);

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-lg shadow-xl max-w-4xl w-full max-h-[90vh] overflow-hidden flex flex-col">
        <div className="flex items-center justify-between p-6 border-b border-gray-200">
          <h2 className="text-xl font-semibold text-gray-900">
            {chapterDetail.chapter.title}
          </h2>
          <button
            onClick={onClose}
            className="text-gray-400 hover:text-gray-600 transition-colors"
          >
            <X className="w-6 h-6" />
          </button>
        </div>

        <div className="p-6 overflow-y-auto">
          <div className="grid grid-cols-2 gap-4 mb-6">
            <div className="bg-amber-50 rounded-lg p-4">
              <div className="flex items-center gap-2 mb-2">
                <FileText className="w-4 h-4 text-amber-600" />
                <div className="text-sm font-semibold text-gray-700">MC問題</div>
              </div>
              <div className="text-2xl font-bold text-amber-600 mb-1">
                {mcCompletionRate.toFixed(1)}%
              </div>
              <div className="text-xs text-gray-500 mb-1">
                {chapterDetail.completedMcTasks} / {chapterDetail.totalMcTasks} 完了
              </div>
              {totalMcReviews > 0 && (
                <div className="flex items-center gap-1 text-xs text-orange-600 font-medium">
                  <AlertCircle className="w-3 h-3" />
                  復習必要: {totalMcReviews}問
                </div>
              )}
            </div>

            <div className="bg-blue-50 rounded-lg p-4">
              <div className="flex items-center gap-2 mb-2">
                <BookOpen className="w-4 h-4 text-blue-600" />
                <div className="text-sm font-semibold text-gray-700">TBS問題</div>
              </div>
              <div className="text-2xl font-bold text-blue-600 mb-1">
                {tbsCompletionRate.toFixed(1)}%
              </div>
              <div className="text-xs text-gray-500 mb-1">
                {chapterDetail.completedTbsTasks} / {chapterDetail.totalTbsTasks} 完了
              </div>
              {totalTbsReviews > 0 && (
                <div className="flex items-center gap-1 text-xs text-orange-600 font-medium">
                  <AlertCircle className="w-3 h-3" />
                  復習必要: {totalTbsReviews}問
                </div>
              )}
            </div>
          </div>

          <div className="space-y-3">
            {chapterDetail.lectures.map((lectureDetail) => {
              const hasAnyTasks = lectureDetail.mcTasks.length > 0 || lectureDetail.tbsTasks.length > 0;
              const mcTotal = lectureDetail.mcTasks.length;
              const tbsTotal = lectureDetail.tbsTasks.length;
              const allMcCompleted = mcTotal > 0 && lectureDetail.mcCompleted === mcTotal;
              const allTbsCompleted = tbsTotal > 0 && lectureDetail.tbsCompleted === tbsTotal;
              const hasReview = lectureDetail.mcPendingReview > 0 || lectureDetail.tbsPendingReview > 0;

              return (
                <div
                  key={lectureDetail.lecture.id}
                  className={`border rounded-lg p-4 hover:border-gray-300 transition-colors ${
                    hasReview ? 'border-orange-300 bg-orange-50/30' : 'border-gray-200'
                  }`}
                >
                  <div className="flex items-start justify-between mb-3">
                    <div className="flex-1">
                      <div className="flex items-center gap-2 mb-1">
                        <h3 className="font-semibold text-gray-900">
                          {lectureDetail.lecture.title}
                        </h3>
                        {hasReview && (
                          <span className="bg-orange-100 text-orange-700 text-xs px-2 py-0.5 rounded-full font-medium">
                            復習あり
                          </span>
                        )}
                      </div>
                      {lectureDetail.lecture.url && (
                        <a
                          href={lectureDetail.lecture.url}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="text-xs text-blue-600 hover:text-blue-700 hover:underline"
                        >
                          講義を見る →
                        </a>
                      )}
                    </div>
                    {allMcCompleted && allTbsCompleted && hasAnyTasks && !hasReview && (
                      <div className="flex items-center gap-1 text-green-600 text-xs font-medium">
                        <CheckCircle className="w-4 h-4" />
                        完了
                      </div>
                    )}
                  </div>

                  <div className="grid grid-cols-2 gap-3">
                    {mcTotal > 0 && (
                      <div className="bg-amber-50 rounded p-3">
                        <div className="text-xs text-gray-600 mb-2 font-medium">MC問題</div>
                        <div className="flex items-center justify-between mb-2">
                          <span className="text-sm font-bold text-amber-600">
                            {lectureDetail.mcCompleted} / {mcTotal}
                          </span>
                          <span className="text-xs text-gray-500">
                            {mcTotal > 0 ? ((lectureDetail.mcCompleted / mcTotal) * 100).toFixed(0) : 0}%
                          </span>
                        </div>
                        <div className="flex items-center gap-3 text-xs">
                          <span className="flex items-center gap-1 text-green-600">
                            <CheckCircle className="w-3 h-3" />
                            {lectureDetail.mcCorrect}
                          </span>
                          <span className="flex items-center gap-1 text-red-600">
                            <XCircle className="w-3 h-3" />
                            {lectureDetail.mcIncorrect}
                          </span>
                          {lectureDetail.mcPendingReview > 0 && (
                            <span className="flex items-center gap-1 text-orange-600">
                              <AlertCircle className="w-3 h-3" />
                              復習{lectureDetail.mcPendingReview}
                            </span>
                          )}
                        </div>
                      </div>
                    )}

                    {tbsTotal > 0 && (
                      <div className="bg-blue-50 rounded p-3">
                        <div className="text-xs text-gray-600 mb-2 font-medium">TBS問題</div>
                        <div className="flex items-center justify-between mb-2">
                          <span className="text-sm font-bold text-blue-600">
                            {lectureDetail.tbsCompleted} / {tbsTotal}
                          </span>
                          <span className="text-xs text-gray-500">
                            {tbsTotal > 0 ? ((lectureDetail.tbsCompleted / tbsTotal) * 100).toFixed(0) : 0}%
                          </span>
                        </div>
                        <div className="flex items-center gap-3 text-xs">
                          <span className="flex items-center gap-1 text-green-600">
                            <CheckCircle className="w-3 h-3" />
                            {lectureDetail.tbsCorrect}
                          </span>
                          <span className="flex items-center gap-1 text-red-600">
                            <XCircle className="w-3 h-3" />
                            {lectureDetail.tbsIncorrect}
                          </span>
                          {lectureDetail.tbsPendingReview > 0 && (
                            <span className="flex items-center gap-1 text-orange-600">
                              <AlertCircle className="w-3 h-3" />
                              復習{lectureDetail.tbsPendingReview}
                            </span>
                          )}
                        </div>
                      </div>
                    )}

                    {mcTotal === 0 && tbsTotal === 0 && (
                      <div className="col-span-2 text-center text-sm text-gray-400 py-2">
                        このセクションには問題がありません
                      </div>
                    )}
                  </div>
                </div>
              );
            })}
          </div>
        </div>

        <div className="border-t border-gray-200 p-4 bg-gray-50">
          <button
            onClick={onClose}
            className="w-full bg-gray-200 text-gray-700 px-4 py-2 rounded-lg font-medium hover:bg-gray-300 transition-colors"
          >
            閉じる
          </button>
        </div>
      </div>
    </div>
  );
}
