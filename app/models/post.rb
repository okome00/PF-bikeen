class Post < ApplicationRecord
  belongs_to :user                                     ## Userモデルとの紐付け
  has_many   :post_comments, dependent: :destroy       ## PoztCommentモデルとの紐付け
  has_many   :favorites,     dependent: :destroy       ## Favoriteモデルとの紐付け

  has_many_attached :images ## ActiveStorage画像投稿
  has_one_attached  :movie  ## ActiveStorage動画投稿

  validates :content, presence: true ## バリデーション設定

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
