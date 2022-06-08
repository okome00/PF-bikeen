class User::FavoritesController < ApplicationController
  before_action :authenticate_user! ## ログイン権限

  def create ## いいね！投稿アクション
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    post.create_notification_favorite!(current_user)
  end

  def destroy ## いいね！削除アクション
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
  end

end
