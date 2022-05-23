class User::NotificationsController < ApplicationController
  before_action :authenticate_user! ## ログイン権限

  def index ## 通知一覧アクション
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy_all ## 通知の全削除アクション
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
