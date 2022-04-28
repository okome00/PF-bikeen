class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      ## カラム追加
      t.integer :user_id ## 会員ID
      t.integer :post_id ## 投稿ID
      t.text    :content ## コメント内容

      t.timestamps
    end
  end
end
