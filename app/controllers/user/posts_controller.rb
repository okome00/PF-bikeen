class User::PostsController < ApplicationController
  before_action :authenticate_user! ## ログイン権限

  def new ## 新規投稿アクション
    @post = Post.new
    @user = current_user
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
    @user = @post.user
    @post_comment = PostComment.new
  end

  def destroy ## 投稿削除アクション
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def hashtag ## ハッシュタグアクション
    @user = current_user
    if params[:name].nil?
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.posts.count}
    else
      @hashtag = Hashtag.find_by(hashname: params[:name])
      @posts = @hashtag.posts
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.posts.count}
    end
  end

  def search ## 投稿検索アクション
    if params[:keyword].present?
      @posts = Post.where('content LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @posts = Post.all
    end
  end

  private ## 投稿データストロングパラメータ

  def post_params
    params.require(:post).permit(:content, :hashbody, :spot, images: [], hashtag_ids: [])
  end

end
