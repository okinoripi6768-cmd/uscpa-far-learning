import { useEffect, useState } from 'react';
import { BookOpen, CheckCircle, XCircle, Clock, TrendingUp, FastForward, Download } from 'lucide-react';
import { getChapterProgress, getOverallStats, getMCStats, downloadMCProgressCSV } from '../lib/progressService';
import { BulkProgressUpdate } from './BulkProgressUpdate';
import { ChapterDetailModal } from './ChapterDetailModal';
import type { ChapterProgress } from '../lib/progressService';
import type { UserSettings } from '../lib/types';

interface ProgressViewProps {
  settings: UserSettings | null;
}

export function ProgressView({ settings }: ProgressViewProps) {
  const [chapterProgress, setChapterProgress] = useState<ChapterProgress[]>([]);
  const [overallStats, setOverallStats] = useState({
    totalTasks: 0,
    completedTasks: 0,
    correctCount: 0,
    incorrectCount: 0,
    pendingReviewCount: 0,
    correctRate: 0,
  });
  const [mcStats, setMcStats] = useState({
    totalTasks: 0,
    completedTasks: 0,
    correctCount: 0,
    incorrectCount: 0,
    pendingReviewCount: 0,
    correctRate: 0,
  });
  const [isLoading, setIsLoading] = useState(true);
  const [showBulkUpdate, setShowBulkUpdate] = useState(false);
  const [selectedChapterId, setSelectedChapterId] = useState<string | null>(null);

  useEffect(() => {
    loadProgress();
  }, [settings]);

  async function loadProgress() {
    if (!settings) return;

    setIsLoading(true);
    try {
      const [chapters, stats, mcStatsData] = await Promise.all([
        getChapterProgress(settings.current_round),
        getOverallStats(settings.current_round),
        getMCStats(settings.current_round),
      ]);
      setChapterProgress(chapters);
      setOverallStats(stats);
      setMcStats(mcStatsData);
    } catch (error) {
      console.error('Error loading progress:', error);
    } finally {
      setIsLoading(false);
    }
  }

  function handleBulkUpdateSuccess() {
    loadProgress();
  }

  async function handleExportMCProgress() {
    if (!settings) return;

    try {
      await downloadMCProgressCSV(settings.current_round);
    } catch (error) {
      console.error('Error exporting MC progress:', error);
      alert('MC問題の進捗データのエクスポートに失敗しました。');
    }
  }

  if (isLoading) {
    return (
      <div className="flex items-center justify-center py-8">
        <div className="text-gray-600">読み込み中...</div>
      </div>
    );
  }

  const completionRate = overallStats.totalTasks > 0
    ? (overallStats.completedTasks / overallStats.totalTasks) * 100
    : 0;

  const mcCompletionRate = mcStats.totalTasks > 0
    ? (mcStats.completedTasks / mcStats.totalTasks) * 100
    : 0;

  return (
    <div className="space-y-4">
      {showBulkUpdate && settings && (
        <BulkProgressUpdate
          currentRound={settings.current_round}
          onClose={() => setShowBulkUpdate(false)}
          onSuccess={handleBulkUpdateSuccess}
        />
      )}

      {selectedChapterId && settings && (
        <ChapterDetailModal
          chapterId={selectedChapterId}
          currentRound={settings.current_round}
          onClose={() => setSelectedChapterId(null)}
        />
      )}

      <div className="bg-gradient-to-r from-blue-500 to-blue-600 text-white rounded-lg shadow-md p-3 sm:p-4">
        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
          <div>
            <h3 className="font-semibold text-base sm:text-lg mb-1">学習プランを更新</h3>
            <p className="text-xs sm:text-sm text-blue-100">
              既に完了したチャプターを一括登録して学習プランを更新
            </p>
          </div>
          <button
            onClick={() => setShowBulkUpdate(true)}
            className="bg-white text-blue-600 px-4 py-2 rounded-lg text-sm sm:text-base font-medium hover:bg-blue-50 transition-colors flex items-center justify-center gap-2 touch-manipulation flex-shrink-0"
          >
            <FastForward className="w-4 h-4" />
            一括登録
          </button>
        </div>
      </div>

      <div className="bg-white rounded-lg shadow-md p-4 sm:p-6">
        <h2 className="text-base sm:text-lg font-semibold text-gray-900 mb-3 sm:mb-4 flex items-center gap-2">
          <TrendingUp className="w-5 h-5" />
          全体サマリー
        </h2>

        <div className="grid grid-cols-2 gap-3 sm:gap-4 mb-3 sm:mb-4">
          <div className="bg-blue-50 rounded-lg p-3 sm:p-4">
            <div className="text-xs sm:text-sm text-gray-600 mb-1">進捗率（全体）</div>
            <div className="text-xl sm:text-2xl font-bold text-blue-600">
              {completionRate.toFixed(1)}%
            </div>
            <div className="text-xs text-gray-500 mt-1">
              {overallStats.completedTasks} / {overallStats.totalTasks}
            </div>
          </div>

          <div className="bg-green-50 rounded-lg p-3 sm:p-4">
            <div className="text-xs sm:text-sm text-gray-600 mb-1">正答率（全体）</div>
            <div className="text-xl sm:text-2xl font-bold text-green-600">
              {overallStats.correctRate.toFixed(1)}%
            </div>
            <div className="text-xs text-gray-500 mt-1">
              {overallStats.correctCount} / {overallStats.correctCount + overallStats.incorrectCount}
            </div>
          </div>
        </div>

        <div className="grid grid-cols-3 gap-2 sm:gap-3 mb-3 sm:mb-4">
          <div className="flex items-center gap-2 text-sm">
            <CheckCircle className="w-4 h-4 text-green-600" />
            <div>
              <div className="text-gray-600">正解</div>
              <div className="font-semibold">{overallStats.correctCount}</div>
            </div>
          </div>

          <div className="flex items-center gap-2 text-sm">
            <XCircle className="w-4 h-4 text-red-600" />
            <div>
              <div className="text-gray-600">不正解</div>
              <div className="font-semibold">{overallStats.incorrectCount}</div>
            </div>
          </div>

          <div className="flex items-center gap-2 text-sm">
            <Clock className="w-4 h-4 text-orange-600" />
            <div>
              <div className="text-gray-600">復習待ち</div>
              <div className="font-semibold">{overallStats.pendingReviewCount}</div>
            </div>
          </div>
        </div>

        <div className="border-t border-gray-200 pt-4 mt-4">
          <div className="flex items-center justify-between mb-3">
            <h3 className="text-sm font-semibold text-gray-700">MC問題のみ</h3>
            <button
              onClick={handleExportMCProgress}
              className="bg-blue-600 text-white px-3 py-1.5 rounded-lg text-xs font-medium hover:bg-blue-700 transition-colors flex items-center gap-1.5 touch-manipulation"
            >
              <Download className="w-3.5 h-3.5" />
              進捗をエクスポート
            </button>
          </div>
          <div className="grid grid-cols-2 gap-4 mb-3">
            <div className="bg-amber-50 rounded-lg p-3">
              <div className="text-xs text-gray-600 mb-1">進捗率</div>
              <div className="text-xl font-bold text-amber-600">
                {mcCompletionRate.toFixed(1)}%
              </div>
              <div className="text-xs text-gray-500 mt-1">
                {mcStats.completedTasks} / {mcStats.totalTasks}
              </div>
            </div>

            <div className="bg-teal-50 rounded-lg p-3">
              <div className="text-xs text-gray-600 mb-1">正答率</div>
              <div className="text-xl font-bold text-teal-600">
                {mcStats.correctRate.toFixed(1)}%
              </div>
              <div className="text-xs text-gray-500 mt-1">
                {mcStats.correctCount} / {mcStats.correctCount + mcStats.incorrectCount}
              </div>
            </div>
          </div>

          <div className="grid grid-cols-3 gap-3">
            <div className="flex items-center gap-2 text-xs">
              <CheckCircle className="w-3 h-3 text-green-600" />
              <div>
                <div className="text-gray-600">正解</div>
                <div className="font-semibold">{mcStats.correctCount}</div>
              </div>
            </div>

            <div className="flex items-center gap-2 text-xs">
              <XCircle className="w-3 h-3 text-red-600" />
              <div>
                <div className="text-gray-600">不正解</div>
                <div className="font-semibold">{mcStats.incorrectCount}</div>
              </div>
            </div>

            <div className="flex items-center gap-2 text-xs">
              <Clock className="w-3 h-3 text-orange-600" />
              <div>
                <div className="text-gray-600">復習待ち</div>
                <div className="font-semibold">{mcStats.pendingReviewCount}</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="bg-white rounded-lg shadow-md p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4 flex items-center gap-2">
          <BookOpen className="w-5 h-5" />
          Chapter別進捗
        </h2>

        <div className="space-y-3">
          {chapterProgress.map((chapter) => {
            const chapterRate = chapter.totalLectures > 0
              ? (chapter.completedLectures / chapter.totalLectures) * 100
              : 0;

            return (
              <div
                key={chapter.chapter.id}
                onClick={() => setSelectedChapterId(chapter.chapter.id)}
                className="border border-gray-200 rounded-lg p-4 hover:border-blue-400 hover:shadow-md transition-all cursor-pointer"
              >
                <div className="flex items-center justify-between mb-2">
                  <div>
                    <div className="font-semibold text-gray-900">
                      {chapter.chapter.title}
                    </div>
                    <div className="text-xs text-gray-500">
                      {chapter.completedLectures} / {chapter.totalLectures} セクション完了
                    </div>
                  </div>
                  <div className="text-right">
                    <div className="text-lg font-bold text-blue-600">
                      {chapterRate.toFixed(0)}%
                    </div>
                  </div>
                </div>

                <div className="w-full bg-gray-200 rounded-full h-2 mb-3">
                  <div
                    className="bg-blue-600 h-2 rounded-full transition-all"
                    style={{ width: `${chapterRate}%` }}
                  />
                </div>

                <div className="flex items-center gap-4 text-xs text-gray-600">
                  <span className="flex items-center gap-1">
                    <CheckCircle className="w-3 h-3 text-green-600" />
                    {chapter.correctCount}
                  </span>
                  <span className="flex items-center gap-1">
                    <XCircle className="w-3 h-3 text-red-600" />
                    {chapter.incorrectCount}
                  </span>
                  {chapter.pendingReviewCount > 0 && (
                    <span className="flex items-center gap-1 text-orange-600 font-medium">
                      <Clock className="w-3 h-3" />
                      復習 {chapter.pendingReviewCount}
                    </span>
                  )}
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}
