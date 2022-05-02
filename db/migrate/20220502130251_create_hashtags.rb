class CreateHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :hashtags do |t|
      ## カラム追加
      t.string :hashtag_name ## ハッシュタグの名前

      t.timestamps
    end
    add_index :hashtags, :hashtag_name, unique: true
  end
end
