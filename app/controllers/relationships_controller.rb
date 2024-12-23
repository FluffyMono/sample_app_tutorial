class RelationshipsController < ApplicationController
  before_action :logged_in_user

  # def create
  #   user = User.find(params[:followed_id])
  #   current_user.follow(user)
  #   redirect_to user
  # end

  # def destroy
  #   user = Relationship.find(params[:id]).followed
  #   current_user.unfollow(user)
  #   redirect_to user, status: :see_other
  # end
  # 
  #以下かっこいいTurboを使ったフォローボタン実装 respond_to と user -> @userが相違点
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.turbo_stream
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user, status: :see_other }
      format.turbo_stream
    end
  end
end