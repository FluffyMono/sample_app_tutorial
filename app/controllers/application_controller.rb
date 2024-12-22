class ApplicationController < ActionController::Base
  #どのコントローラからでもログイン関連(sessions)のメソッドを呼び出せるように記載
  include SessionsHelper
  
  private

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end
end
