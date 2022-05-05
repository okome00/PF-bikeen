class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      ## カラム追加
      t.integer :user_id  ## 会員ID
      t.text    :content  ## 投稿内容
      t.text    :hashbody ## ハッシュタグの内容
      t.string  :spot     ## 投稿スポット

      t.timestamps
    end
  end
end
