class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      ## カラム追加
      t.integer :follower_id ## フォローしたユーザー
      t.integer :followed_id ## フォローされたユーザー

      t.timestamps
    end
  end
end
