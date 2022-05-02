class Hashtag < ApplicationRecord
  has_many :post_hashtags, dependent: :destroy ## PostHashtagモデルとの紐付け
  has_many :posts, through: :post_hashtags     ## Postモデルとの紐付け
  
  validates :hashtag_name, presence: true, length: { maximum: 50 }
end
