class PostComment < ApplicationRecord
  belongs_to :user                               ## Userモデルとの紐付け
  belongs_to :post                               ## Postモデルとの紐付け
  has_many   :notifications, dependent: :destroy ## Notificationモデルとの紐付け
end
