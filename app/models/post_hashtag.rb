class PostHashtag < ApplicationRecord
  belongs_to :post    ## Postモデルとの紐付け
  belongs_to :hashtag ## Hashtagモデルとの紐付け

  validates :post_id,    presence: true
  validates :hashtag_id, presence: true

end
