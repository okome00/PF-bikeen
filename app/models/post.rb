class Post < ApplicationRecord
  belongs_to :user ## Userモデルとの紐付け
  
  has_many_attached :images ## ActiveStorage画像投稿
  has_one_attached  :movie  ## ActiveStorage動画投稿
end
