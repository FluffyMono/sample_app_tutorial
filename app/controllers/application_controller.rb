class ApplicationController < ActionController::Base
  #どのコントローラからでもログイン関連(sessions)のメソッドを呼び出せるように記載
  include SessionsHelper
end
