class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User" ## Userモデルを参照
  belongs_to :followed, class_name: "User" ## Userモデルを参照
end
