module NotificationsHelper
  
  def notification_form(notification)
    @visiter = notification.visiter#誰が
    @comment = nil
    @visiter_pcomment = notification.pcomment_id#どのコメントをした
    

    #通知内容によって内容を返却させる
    case notification.action
      when "follow" then
        tag.a(@visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
      when "like" then
        tag.a(@visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a("あなたの投稿", href:practice_path(notification.practice_id), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
          @pcomment = Pcomment.find_by(id: @visiter_comment)&.content
          tag.a(@visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a("あなたの投稿", href:practice_path(notification.practice_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end

  def unchecked_notifications #未読の通知があるかどうか
    @notifications = current_user.passive_notifications.where(checked: false)
end

end
