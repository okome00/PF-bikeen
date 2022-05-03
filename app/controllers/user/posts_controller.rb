class User::PostsController < ApplicationController
  before_action :authenticate_user! ## ログイン権限

  def new ## 新規投稿アクション
    @post = Post.new
  end

  def create ## 投稿アクション
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    hashtag = extract_hashtag(@post.content) ## パラメータのcontentカラムからハッシュタグを抽出
    if @post.save
      save_hashtag(hashtag, @post) ## 抽出したハッシュタグをhashtagテーブルへ、作成したpost_idとhashtag_idをpost_hashtagテーブルへ保存
      redirect_to posts_path
    else
      render :new
    end
  end

  def index ## 投稿一覧表示アクション
    @posts = Post.all
    @hashtags = Hashtag.all
    @post_hashtags = PostHashtag.all
    @post_objects = creating_structures(posts: @posts, post_hashtags: @post_hashtags, hashtags: @hashtags)
  end

  def show ## 投稿詳細表示アクション
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
    related_records = PostHashtag.where(post_id: @post.id).pluck(:hashtag_id) ## => [1,2,3] idのみを配列にして返す
    hashtags = Hashtag.all
    @hashtags = hashtags.select{|hashtag| related_records.include?(hashtag_id)} ## hashtagテーブルよりpost_hashtagテーブルで取得したidのハッシュタグを取得
    @display_content = @post.content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/,"") ## 実際に表示する内容 / ハッシュタグが文字列のまま表示されてしまう為、#から始まる文字列を""に変換したものをViewにて表示
  end

  def destroy ## 投稿削除アクション
    @post = Post.find(params[:id])
    @post.destroy
    delete_records_related_to_hashtag(params[:id]) ## post_hashtagテーブルとハッシュタグのレコードを削除
    redirect_to posts_path
  end

  private ## 投稿データストロングパラメータ

  def post_params
    params.require(:post).permit(:content, :spot, :movie, images: [])
  end

end
