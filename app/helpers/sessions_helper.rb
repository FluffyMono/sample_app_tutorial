module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーを返す（いる場合）
  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id])
    # findでは引数が存在しない場合、例外を発生させエラーなりが起こるが、
    # find_byだとnilを返し直ちにアクションを終了させる。
    # 今回はログイン関連なので、ユーザーのプロフィール画像等の検索と違いfind_byを使うのが良い
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    reset_session
    @current_user = nil # 安全のため
  end
end
