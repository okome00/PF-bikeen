class Post < ApplicationRecord
  belongs_to :user                               ## Userモデルとの紐付け
  has_many   :post_comments, dependent: :destroy ## PoztCommentモデルとの紐付け
  has_many   :favorites,     dependent: :destroy ## Favoriteモデルとの紐付け
  has_many   :hashtag_posts, dependent: :destroy ## HashtagPostモデルとの紐付け
  has_many   :hashtags, through: :hashtag_posts  ## Hashtagモデルとの紐付け

  has_many_attached :images ## ActiveStorage画像投稿
  has_one_attached  :movie  ## ActiveStorage動画投稿

  validates :images,  presence: true ## バリデーション設定
  validates :content, presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  after_create do ## 投稿時にハッシュタグ内容を保存
    post = Post.find_by(id: id)
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) ## hashbody内のハッシュタグを抽出
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#')) ## ハッシュタグは先頭の"#"を外して保存
      post.hashtags << tag
    end
  end

  before_update do ## 更新保存アクション(※編集機能はない為使用しない)
    post = Post.find_by(id: id)
    post.hashtags.clear
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end
end
