module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
    # セッションリプレイ攻撃から保護する
    # 詳しくは https://techracho.bpsinc.jp/hachi8833/2023_06_02/130443 を参照
    session[:session_token] = user.session_token
  end

  # 永続的セッションのためにユーザーをデータベースに記憶する
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 現在ログイン中の(記憶トークンcookieに対応する)ユーザーを返す（いる場合）
  def current_user
    # ユーザーIDにユーザーIDのセッションを代入した結果）ユーザーIDのセッションが存在すれば
    if (user_id = session[:user_id])
      user = User.find_by(id: user_id)
      @current_user = user if user && session[:session_token] == user.session_token
    elsif (user_id = cookies.encrypted[:user_id])
      # raise #例外を発生させる。テストがパスすれば、この部分がテストされていないことがわかる
      # sessions_helperにて解決済み
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
    # findでは引数が存在しない場合、例外を発生させエラーなりが起こるが、
    # find_byだとnilを返し直ちにアクションを終了させる。
    # 今回はログイン関連なので、ユーザーのプロフィール画像等の検索と違いfind_byを使うのが良い
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    reset_session
    @current_user = nil # 安全のため
  end

  # 渡されたユーザーがカレントユーザーであればtrueを返す
  def current_user?(user)
    user && user == current_user
  end

  # アクセスしようとしたURLを保存する
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
