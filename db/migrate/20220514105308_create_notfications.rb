class CreateNotfications < ActiveRecord::Migration[6.1]
  def change
    create_table :notfications do |t|
      ## カラム追加
      t.integer :visitor_id                           # 通知を送ったユーザーid
      t.integer :visited_id                           # 通知を送られたユーザーid
      t.integer :post_id                              # いいねされた投稿id
      t.integer :post_comment_id                      # 投稿へのコメントid
      t.string  :action                               # 通知の種類(フォロー、いいね！、コメント)
      t.boolean :checked, default: false, null: false # 通知を送られたユーザーが通知を確認したか

      t.timestamps
    end
  end
end
