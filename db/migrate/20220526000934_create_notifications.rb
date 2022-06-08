class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      ## カラム追加
      t.integer :visitor_id, null: false              ## 通知を送ったユーザーid
      t.integer :visited_id, null: false              ## 通知を送られたユーザーid
      t.integer :post_id                              ## いいねされた投稿id
      t.integer :post_comment_id                      ## 投稿へのコメントid
      t.string  :action,  default: '', null: false    ## 通知の種類（フォロー、いいね、コメント）
      t.boolean :checked, default: false, null: false ## 通知を送られたユーザーが通知を確認したか

      t.timestamps
    end
    
    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :post_id
    add_index :notifications, :post_comment_id
  end
end
