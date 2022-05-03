class CreatePostHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_hashtags do |t|
      ## カラム追加
      t.integer :post_id    ## post_idを取得
      t.integer :hashtag_id ## hashtag_idを取得

      t.timestamps
    end
  end
end
