class User::RelationshipsController < ApplicationController
  def create ## フォローする時
    current_user.follow(params[:user_id])
    @user = User.find(params[:relationship][:followed_id])
    @user.create_notification_follow!(current_user)
    redirect_to request.referer
  end

  def destroy ## フォローを外す時
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings ## フォロー一覧
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers ## フォロワー一覧
    user = User.find(params[:user_id])
    @users = user.followers
  end

end
