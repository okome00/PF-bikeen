module User::NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor
    @post_comment = nil
    your_post = link_to "あなたの投稿", post_path(notification), style: "font-weight: bold;"
    @visitor_post_comment = notification.post_comment_id
    
    case notification.action ## 通知かフォロー/いいね！/コメントかを判別
      when "follow" then
        tag.a(notification.visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "があなたをフォローしました"
      
      when "favorite" then
        tag.a(notification.visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "が" + tag.a("あなたの投稿", href: post_path(notification.post_id), style: "font-weight: bold;") + "にいいね！しました"
      when "post_comment" then
        @post_comment = PostComment.find_by(id: @visitor_post_comment)&.content
        tag.a(@visiter.name, href: user_path(@visitor), style: "font-weight: bold;") + "が" + tag.a("あなたの投稿", href: post_path(notification.post_id), style: "font-weight: bold;") + "にコメントしました"
    end
  end
  
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
