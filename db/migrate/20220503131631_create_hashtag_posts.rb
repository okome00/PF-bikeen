class CreateHashtagPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :hashtag_posts do |t|
      ## カラム追加
      t.references :post, foreign_key: true    ## post_id取得
      t.references :hashtag, foreign_key: true ## hashtag_id取得

      t.timestamps
    end
  end
end
