class PcommentsController < ApplicationController
  def create
    @practice=Practice.find(params[:practice_id])  
    @pcomment=Pcomment.new(pcomment_params)
    if @pcomment.save
      @practice.create_notification_comment!(current_user,@pcomment.id,@practice.user_id) #投稿に紐づくコメントが来たという通知
      redirect_to practice_path(@practice)
    else
      @pcomments=Pcomment.where(practice_id:@practice.id)
      render "practices/show"
    end
  end
  
  private
  def pcomment_params
    params.require(:pcomment).permit(:comment).merge(user_id:current_user.id,practice_id:params[:practice_id])
  end
end
