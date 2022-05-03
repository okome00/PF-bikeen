class Hashtag < ApplicationRecord
  validates :hashtag_name, presence: true, length: { maximum: 99 } ## バリデーション設定
end
