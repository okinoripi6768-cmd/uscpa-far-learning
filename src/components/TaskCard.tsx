import { useState, useEffect } from 'react';
import { Check, X, BookOpen, ListChecks, FileText, Clock, ExternalLink, StickyNote, ChevronDown, ChevronUp, MessageCircle } from 'lucide-react';
import type { DailyTask, TaskResult } from '../lib/types';
import { recordStudySession } from '../lib/studyTimeService';
import { ChatModal } from './ChatModal';

interface TaskCardProps {
  dailyTask: DailyTask;
  onComplete: (result: TaskResult | null, notes?: string) => void;
  isProcessing: boolean;
}

export function TaskCard({ dailyTask, onComplete, isProcessing }: TaskCardProps) {
  const { task, chapter, lecture, isPriority, progress } = dailyTask;
  const [startTime] = useState(Date.now());
  const [elapsedMinutes, setElapsedMinutes] = useState(0);
  const [showNoteInput, setShowNoteInput] = useState(false);
  const [showPreviousNote, setShowPreviousNote] = useState(false);
  const [showChatModal, setShowChatModal] = useState(false);
  const [noteText, setNoteText] = useState('');
  const [completionResult, setCompletionResult] = useState<TaskResult | null>(null);

  useEffect(() => {
    const interval = setInterval(() => {
      const elapsed = Math.floor((Date.now() - startTime) / 60000);
      setElapsedMinutes(elapsed);
    }, 60000);

    return () => clearInterval(interval);
  }, [startTime]);

  const handleComplete = async (result: TaskResult | null, notes?: string) => {
    const actualMinutes = Math.max(1, Math.floor((Date.now() - startTime) / 60000));

    try {
      await recordStudySession(
        actualMinutes,
        chapter.id,
        task.id,
        task.task_type,
        `Completed: ${result || 'viewed'}`
      );
    } catch (error) {
      console.error('Error recording study session:', error);
    }

    onComplete(result, notes);
  };

  const handleResultSelect = (result: TaskResult | null) => {
    setCompletionResult(result);
    setShowNoteInput(true);
  };

  const handleSubmitWithNote = () => {
    handleComplete(completionResult, noteText.trim() || undefined);
  };

  const handleSkipNote = () => {
    handleComplete(completionResult, undefined);
  };

  const getTaskIcon = () => {
    switch (task.task_type) {
      case 'lecture':
        return <BookOpen className="w-6 h-6" />;
      case 'mc':
        return <ListChecks className="w-6 h-6" />;
      case 'tbs':
        return <FileText className="w-6 h-6" />;
    }
  };

  const getTaskTypeLabel = () => {
    switch (task.task_type) {
      case 'lecture':
        return '講義視聴';
      case 'mc':
        return 'MC問題演習';
      case 'tbs':
        return 'TBS問題演習';
    }
  };

  return (
    <div className={`bg-white rounded-lg shadow-md p-4 sm:p-6 mb-3 sm:mb-4 ${isPriority ? 'border-2 border-orange-400' : ''}`}>
      {isPriority && (
        <div className="text-xs font-semibold text-orange-600 mb-2">
          復習期限到来
        </div>
      )}

      {progress?.notes && (
        <div className="mb-3 sm:mb-4">
          <button
            onClick={() => setShowPreviousNote(!showPreviousNote)}
            className="w-full flex items-center justify-between p-2 bg-yellow-50 border border-yellow-200 rounded-lg hover:bg-yellow-100 transition-colors touch-manipulation"
          >
            <div className="flex items-center gap-2">
              <StickyNote className="w-4 h-4 text-yellow-600" />
              <span className="text-sm font-medium text-yellow-800">前回のメモ</span>
            </div>
            {showPreviousNote ? (
              <ChevronUp className="w-4 h-4 text-yellow-600" />
            ) : (
              <ChevronDown className="w-4 h-4 text-yellow-600" />
            )}
          </button>
          {showPreviousNote && (
            <div className="mt-2 p-3 bg-yellow-50 border border-yellow-200 rounded-lg">
              <div className="text-sm text-yellow-900 whitespace-pre-wrap">{progress.notes}</div>
            </div>
          )}
        </div>
      )}

      <div className="flex items-start gap-2 sm:gap-3 mb-3 sm:mb-4">
        <div className="text-blue-600 mt-1 flex-shrink-0">
          {getTaskIcon()}
        </div>
        <div className="flex-1 min-w-0">
          <div className="flex items-center justify-between mb-1">
            <div className="text-xs sm:text-sm text-gray-500 truncate">
              {chapter.title}
            </div>
          </div>
          {lecture && (
            <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-2 p-2 bg-blue-50 rounded border border-blue-100 gap-2">
              <div className="flex items-center gap-2 min-w-0">
                <BookOpen className="w-4 h-4 text-blue-600 flex-shrink-0" />
                <span className="text-xs sm:text-sm text-blue-900 font-medium truncate">
                  セクション {chapter.chapter_number}-{lecture.lecture_number}: {lecture.title}
                </span>
              </div>
              {lecture.video_url && (
                <a
                  href={lecture.video_url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex items-center gap-1 text-xs text-blue-600 hover:text-blue-700 hover:underline flex-shrink-0 self-start sm:self-auto touch-manipulation"
                >
                  <ExternalLink className="w-3 h-3" />
                  {task.task_type === 'lecture' ? '開く' : '視聴'}
                </a>
              )}
            </div>
          )}
          {lecture && false && (task.task_type === 'mc' || task.task_type === 'tbs') && (
            <div className="flex items-center justify-between mb-2 p-2 bg-blue-50 rounded border border-blue-100">
              <div className="flex items-center gap-2">
                <BookOpen className="w-4 h-4 text-blue-600" />
                <span className="text-sm text-blue-900 font-medium">
                  セクション {chapter.chapter_number}-{lecture.lecture_number}: {lecture.title}
                </span>
              </div>
              {lecture.video_url && (
                <a
                  href={lecture.video_url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="flex items-center gap-1 text-xs text-blue-600 hover:text-blue-700 hover:underline ml-2"
                >
                  <ExternalLink className="w-3 h-3" />
                  視聴
                </a>
              )}
            </div>
          )}
          <h3 className="text-base sm:text-lg font-semibold text-gray-900 mb-1">
            {task.title}
          </h3>
          <div className="flex flex-col sm:flex-row sm:items-center gap-1 sm:gap-3 text-xs sm:text-sm text-gray-600">
            <span>{getTaskTypeLabel()} • {task.task_code}</span>
            {elapsedMinutes > 0 && (
              <span className="flex items-center gap-1 text-blue-600">
                <Clock className="w-3 h-3" />
                {elapsedMinutes}分経過
              </span>
            )}
          </div>
        </div>
      </div>

      <button
        onClick={() => setShowChatModal(true)}
        className="w-full mb-3 sm:mb-4 flex items-center justify-center gap-2 px-4 py-2.5 sm:py-2 bg-gradient-to-r from-purple-500 to-blue-500 text-white rounded-lg text-sm sm:text-base font-medium hover:from-purple-600 hover:to-blue-600 transition-all shadow-md touch-manipulation"
      >
        <MessageCircle className="w-4 h-4" />
        質問する
      </button>

      {showChatModal && (
        <ChatModal
          taskTitle={`${chapter.title} - ${task.title}`}
          onClose={() => setShowChatModal(false)}
        />
      )}

      {showNoteInput ? (
        <div className="space-y-3">
          <div>
            <label className="block text-xs sm:text-sm font-medium text-gray-700 mb-2">
              メモ（任意）- 復習時の注意点を記録
            </label>
            <textarea
              value={noteText}
              onChange={(e) => setNoteText(e.target.value)}
              placeholder="例: 選択肢の読み間違い、計算ミス、概念の理解不足、重要なポイントなど"
              className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none text-sm sm:text-base"
              rows={3}
              autoFocus
            />
          </div>
          <div className="flex flex-col sm:flex-row gap-2 sm:gap-3">
            <button
              onClick={() => {
                setShowNoteInput(false);
                setNoteText('');
                setCompletionResult(null);
              }}
              disabled={isProcessing}
              className="flex-1 bg-gray-500 text-white py-2.5 sm:py-3 rounded-lg text-sm sm:text-base font-semibold disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-600 transition-colors touch-manipulation"
            >
              キャンセル
            </button>
            <button
              onClick={handleSkipNote}
              disabled={isProcessing}
              className="flex-1 bg-gray-400 text-white py-2.5 sm:py-3 rounded-lg text-sm sm:text-base font-semibold disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-500 transition-colors touch-manipulation"
            >
              {isProcessing ? '処理中...' : 'メモなしで完了'}
            </button>
            <button
              onClick={handleSubmitWithNote}
              disabled={isProcessing}
              className="flex-1 bg-blue-600 text-white py-2.5 sm:py-3 rounded-lg text-sm sm:text-base font-semibold flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed hover:bg-blue-700 transition-colors touch-manipulation"
            >
              {isProcessing ? '処理中...' : 'メモを保存'}
            </button>
          </div>
        </div>
      ) : task.task_type === 'lecture' ? (
        <button
          onClick={() => handleResultSelect(null)}
          disabled={isProcessing}
          className="w-full bg-blue-600 text-white py-2.5 sm:py-3 rounded-lg text-sm sm:text-base font-semibold disabled:opacity-50 disabled:cursor-not-allowed hover:bg-blue-700 transition-colors touch-manipulation"
        >
          完了
        </button>
      ) : (
        <div className="flex gap-2 sm:gap-3">
          <button
            onClick={() => handleResultSelect('correct')}
            disabled={isProcessing}
            className="flex-1 bg-green-600 text-white py-2.5 sm:py-3 rounded-lg text-sm sm:text-base font-semibold flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed hover:bg-green-700 transition-colors touch-manipulation"
          >
            <Check className="w-4 h-4 sm:w-5 sm:h-5" />
            正解
          </button>
          <button
            onClick={() => handleResultSelect('incorrect')}
            disabled={isProcessing}
            className="flex-1 bg-red-600 text-white py-2.5 sm:py-3 rounded-lg text-sm sm:text-base font-semibold flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed hover:bg-red-700 transition-colors touch-manipulation"
          >
            <X className="w-4 h-4 sm:w-5 sm:h-5" />
            不正解
          </button>
        </div>
      )}
    </div>
  );
}
