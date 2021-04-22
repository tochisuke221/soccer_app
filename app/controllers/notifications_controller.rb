class NotificationsController < ApplicationController
  def index
    #自分宛の通知を一気に集める
    @notifications=current_user.passive_notifications
    #未読・既読の更新を行う
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy #全消去
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to users_notifications_path
  end

end

