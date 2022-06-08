class User::NotificationsController < ApplicationController
  def index ## 通知一覧アクション
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
