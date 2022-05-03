class Hashtag < ApplicationRecord
  has_and_belongs_to_many :posts ## Postモデルとの紐付け(多対多の関係)
  
  validates :hashtag_name, presence: true, length: { maximum: 99 }
end
