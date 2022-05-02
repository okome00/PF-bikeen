class Favorite < ApplicationRecord
  belongs_to :user ## Userモデルとの紐付け
  belongs_to :post ## Postモデルとの紐付け
end
