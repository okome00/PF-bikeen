class Notfication < ApplicationRecord
  default_scope -> { order(created_at: :desc) } ## デフォルトの並び順を作成日時の降順で指定
  belongs_to :post,         optional: true      ## Postモデルとの紐付け
  belongs_to :post_comment, optional: true      ## PostCommentモデルとの紐付け
  
  belongs_to :visitor_id, class_name: "User", foreign_key: "visitor_id", optional: true
  belongs_to :visited_id, class_name: "User", foreign_key: "visited_id", optional: true
end
