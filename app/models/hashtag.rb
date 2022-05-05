class Hashtag < ApplicationRecord
  has_many :hashtag_posts, dependent: :destroy ## HashtagPostモデルとの紐付け
  has_many :posts, through: :hashtag_posts     ## Postモデルとの紐付け
  
  validates :hashname, presence: true, length: { maximum: 99 } ## バリデーション設定
end
