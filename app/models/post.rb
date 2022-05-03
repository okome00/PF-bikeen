class Post < ApplicationRecord
  belongs_to :user                                     ## Userモデルとの紐付け
  has_many   :post_comments, dependent: :destroy       ## PoztCommentモデルとの紐付け
  has_many   :favorites,     dependent: :destroy       ## Favoriteモデルとの紐付け
  has_many   :post_hashtags, dependent: :destroy       ## PostHashhagモデルとの紐付け
  has_many   :hashtahs,      through:   :post_hashtags ## Hashtagモデルとの紐付け

  has_many_attached :images ## ActiveStorage画像投稿
  has_one_attached  :movie  ## ActiveStorage動画投稿

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  after_create do ## 投稿時にハッシュタグがhashtagsテーブルに保存される
    post = Post.find_by(id: self.id)
    hashtags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashtag_name: hashtag.downcase.delete('#')) ## ハッシュタグは先頭の'#'を外して保存
      post.hashtags << tag
    end
  end

  before_update do ## 更新時に保存(※編集機能はないので使用しない)
    post = Post.find_by(id: self.id)
    post.hashtags.clear
    hashtags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashtag_name: hashtag.downcase.delete('#')) ## ハッシュタグは先頭の'#'を外して保存
      post.hashtags << tag
    end
  end

end
