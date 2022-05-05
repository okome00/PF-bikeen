class HashtagPost < ApplicationRecord
  belongs_to :post    ## Postモデルとの紐付け
  belongs_to :hashtag ## Hashtagモデルとの紐付け
  
  validates :post_id,    presence: true ## バリデーション設定
  validates :hashtag_id, presence: true
end
