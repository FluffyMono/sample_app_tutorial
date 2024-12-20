class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    # !!ここではstrong parameterのuser_paramsを使わないとActiveModel::ForbittenAttributes errorが起こる
    @user = User.new(user_params) # (params[:user])は on private
    if @user.save
      # flashを作成したらレイアウトをapplicationhtmlに記載
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  # privateはweb経由で使ってほしくないもの(params[:user])を入れる。it is in controller limitedly so it works.
  # インデントして強調　実行順が変わるのではなく単に重要な項目を見つけやすくする意図

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
