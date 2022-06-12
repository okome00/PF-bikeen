class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts,         dependent: :destroy ## Postモデルとの紐付け
  has_many :post_comments, dependent: :destroy ## PostCommentモデルとの紐付け
  has_many :favorites,     dependent: :destroy ## Favoriteモデルとの紐付け
  has_many :relationships,            class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy ## フォローした場合の関係
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy ## フォローされた場合の関係
  has_many :followings, through: :relationships, source: :followed                                                ## 自分がフォローしてる人
  has_many :followers,  through: :reverse_of_relationships, source: :follower                                     ## 自分をフォローしている人
  has_many :active_notifications,  class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy     ## 自分からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy     ## 相手からの通知

  has_one_attached :profile_image ## ActiveStorageでプロフィール画像表示

  def get_profile_image(width, height) ## プロフィール画像表示設定
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_user.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def follow(user_id) ## フォローした時の処理
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id) ## フォローを外す時の処理
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user) ## フォローしているか判定
    followings.include?(user)
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
