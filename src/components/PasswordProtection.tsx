import { useState } from 'react';
import { Lock } from 'lucide-react';

interface PasswordProtectionProps {
  onAuthenticated: () => void;
}

export function PasswordProtection({ onAuthenticated }: PasswordProtectionProps) {
  const [password, setPassword] = useState('');
  const [error, setError] = useState(false);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    // 簡易パスワード - 環境変数から取得することを推奨
    const correctPassword = 'FAR2026';

    if (password === correctPassword) {
      setError(false);
      onAuthenticated();
    } else {
      setError(true);
      setPassword('');
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 flex items-center justify-center p-4">
      <div className="max-w-md w-full bg-white rounded-xl shadow-2xl p-8">
        <div className="flex items-center justify-center mb-6">
          <div className="bg-blue-100 p-4 rounded-full">
            <Lock className="w-8 h-8 text-blue-600" />
          </div>
        </div>

        <h1 className="text-2xl font-bold text-center text-slate-900 mb-2">
          アクセス制限中
        </h1>
        <p className="text-center text-slate-600 mb-6">
          このアプリケーションは現在非公開です
        </p>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label htmlFor="password" className="block text-sm font-medium text-slate-700 mb-2">
              パスワードを入力してください
            </label>
            <input
              id="password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className={`w-full px-4 py-3 rounded-lg border ${
                error ? 'border-red-500' : 'border-slate-300'
              } focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition-all`}
              placeholder="パスワード"
              autoFocus
            />
            {error && (
              <p className="mt-2 text-sm text-red-600">
                パスワードが正しくありません
              </p>
            )}
          </div>

          <button
            type="submit"
            className="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-lg transition-colors"
          >
            ログイン
          </button>
        </form>
      </div>
    </div>
  );
}
