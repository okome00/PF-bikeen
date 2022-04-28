class User::PostCommentsController < ApplicationController
  before_action :authenticate_user! ## ログイン権限

  def create ## コメント投稿アクション
    post = Post.find(params[post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
  end

  private ## コメント投稿データストロングパラメータ

  def post_comment_params
  params.require(:post_comment).permit(:comment)
  end

end
