class CreatePostHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_hashtags do |t|
      ## カラム追加
      t.references :post,    index: true, foreign_key: true    ## post_idを取得
      t.references :hashtag, index: true, foreign_key: true ## hashtag_idを取得

      t.timestamps
    end
  end
end
