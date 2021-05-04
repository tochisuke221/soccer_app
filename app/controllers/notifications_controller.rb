class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    # 自分宛の通知を一気に集める
    @notifications = current_user.passive_notifications
    # indexを開いた時点で、全部既読にする
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy_all
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
