class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      ## カラム追加
      t.integer :user_id ## 会員ID
      t.integer :post_id ## 投稿ID

      t.timestamps
    end
  end
end
