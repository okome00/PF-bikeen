class User::FavoritesController < ApplicationController
  before_action :authenticate_user! ## ログイン権限

  def create ## いいね！投稿アクション
    post = Post.find(params[:post_id])
    post.create_notification_favorite!(current_user)
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    redirect_to post_path(post)
  end

  def destroy ## いいね！削除アクション
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to post_path(post)
  end

end
