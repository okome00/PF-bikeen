class Post < ApplicationRecord
  belongs_to :user                               ## Userモデルとの紐付け
  has_many   :post_comments, dependent: :destroy ## PoztCommentモデルとの紐付け
  has_many   :favorites,     dependent: :destroy ## Favoriteモデルとの紐付け
  has_many   :hashtag_posts, dependent: :destroy ## HashtagPostモデルとの紐付け
  has_many   :hashtags, through: :hashtag_posts  ## Hashtagモデルとの紐付け
  has_many   :notifications, dependent: :destroy ## Notificationモデルとの紐付け

  has_many_attached :images ## ActiveStorage画像投稿
  has_one_attached  :movie  ## ActiveStorage動画投稿

  validates :images,  presence: true ## バリデーション設定
  validates :content, presence: true 

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  after_create do ## 投稿時にハッシュタグ内容を保存
    post = Post.find_by(id: id)
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) ## hashbody内のハッシュタグを抽出
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#')) ## ハッシュタグは先頭の"#"を外して保存
      post.hashtags << tag
    end
  end

  before_update do ## 更新保存アクション(※編集機能はない為使用しない)
    post = Post.find_by(id: id)
    post.hashtags.clear
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end
  
  def create_notification_favorite!(current_user)
    ## 既にいいね！されているか検索
    temp = Notfication.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, "favorite"])
  
    ## いいね！されていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: "favorite"
      )
      
      ## 自分の投稿に対するいいね！の場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  def create_notification_post_comment!(current_user, post_comment_id)
    
    ## 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).destinct
    temp_ids.each do |temp_id|
      save_notification_post_comment!(current_user, post_comment_id, temp_id["user_id"])
    end
    
    ## 誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_post_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end
  
  def save_notification_post_comment!(current_user, post_comment_id, visited_id)
    
    ## コメントは複数回すことが考えられる為、1つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: "post_comment"
    )
    
    ## 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
  
  def create_notification_relationship!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, id, "relationship"])
    if temp.blank?
      notification = current_user.action_notifications.new(
        visited_id: id,
        action: "relationship"
      )
      notification.save if notification.valid?
    end
  end
end

