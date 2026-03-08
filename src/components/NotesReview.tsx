import { useEffect, useState } from 'react';
import { BookOpen, ChevronRight, ChevronDown } from 'lucide-react';
import { getTodaysNotes } from '../lib/taskService';

interface TaskNote {
  taskTitle: string;
  chapterTitle: string;
  notes: string;
  completedAt: string;
}

export function NotesReview() {
  const [notes, setNotes] = useState<TaskNote[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isExpanded, setIsExpanded] = useState(true);

  useEffect(() => {
    loadNotes();
  }, []);

  async function loadNotes() {
    setIsLoading(true);
    try {
      const data = await getTodaysNotes();
      setNotes(data);
    } catch (error) {
      console.error('Error loading notes:', error);
    } finally {
      setIsLoading(false);
    }
  }

  if (isLoading) {
    return null;
  }

  if (notes.length === 0) {
    return null;
  }

  return (
    <div className="bg-white rounded-lg shadow-md p-4 mb-6">
      <button
        onClick={() => setIsExpanded(!isExpanded)}
        className="flex items-center gap-2 mb-3 w-full text-left hover:opacity-80 transition-opacity"
      >
        {isExpanded ? (
          <ChevronDown className="w-5 h-5 text-blue-600" />
        ) : (
          <ChevronRight className="w-5 h-5 text-blue-600" />
        )}
        <BookOpen className="w-5 h-5 text-blue-600" />
        <h3 className="font-semibold text-gray-900">今日のメモ</h3>
        <span className="text-sm text-gray-500 ml-auto">({notes.length})</span>
      </button>
      {isExpanded && (
        <div className="space-y-3">
          {notes.map((note, index) => (
            <div key={index} className="border-l-4 border-blue-500 pl-3 py-2 bg-blue-50 rounded-r">
              <div className="text-sm font-medium text-gray-900 mb-1">
                {note.chapterTitle} - {note.taskTitle}
              </div>
              <div className="text-sm text-gray-700 whitespace-pre-wrap">
                {note.notes}
              </div>
              <div className="text-xs text-gray-500 mt-1">
                {new Date(note.completedAt).toLocaleTimeString('ja-JP', {
                  hour: '2-digit',
                  minute: '2-digit'
                })}
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
