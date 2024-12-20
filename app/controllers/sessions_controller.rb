class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user&.authenticate(params[:session][:password])
      reset_session # !!!!
      log_in user
      redirect_to user # ewual to redirect_to user_url(user)
    else
      # flashだとエラー後にhomeに戻ってもそのままメッセージが表示されるのでrender前はflash.nowを使う
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    #Turboを使うときは DELETEリクエスト後にsee other
    redirect_to root_url, status: :see_other
  end
end
