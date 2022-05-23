class Notfication < ApplicationRecord
  default_scope -> { order(created_at: :desc) } ## 新しい通知順に表示

  belongs_to :post,         optional: true      ## Postモデルとの紐付け
  belongs_to :post_comment, optional: true      ## PostCommentモデルとの紐付け
  belongs_to :visitor, class_name: "User", foreign_key: "visitor_id", optional: true
  belongs_to :visited, class_name: "User", foreign_key: "visited_id", optional: true
end
