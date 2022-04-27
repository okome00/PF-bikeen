class User::PostsController < ApplicationController
  def new ## 新規投稿アクション
    @post = Post.new
  end

  def create ## 投稿アクション
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index ## 投稿一覧表示アクション
    @posts = Post.all
  end

  def show ## 投稿詳細表示アクション
    @post = Post.find(params[:id])
  end

  def destroy ## 投稿削除アクション
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private ## 投稿データストロングパラメータ

  def post_params
    params.require(:post).permit(:content, :spot, :movie, images: [])
  end

end
