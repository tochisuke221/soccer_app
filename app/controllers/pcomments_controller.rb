class PcommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_practice, only: [:create, :destroy]
  before_action :set_comment, only: [:destroy]
  before_action :move_to_root, only: [:destroy]

  def create
    @pcomment = Pcomment.new(pcomment_params)
    if @pcomment.save
      @pcomments = Pcomment.order('created_at DESC').where(practice_id: @practice.id)
      @practice.create_notification_comment!(current_user, @pcomment.id, @practice.user_id) # 投稿に紐づくコメントが来たという通知
    else
      @pcomments = Pcomment.where(practice_id: @practice.id)
      @ptags = @practice.ptags
      render 'practices/show'
    end
  end

  def destroy
    @pcomment.destroy
    @pcomments = Pcomment.where(practice_id: @practice.id)
    # redirect_to practice_path(@practice)
  end

  private

  def set_practice
    @practice = Practice.find(params[:practice_id])
  end

  def set_comment
    @pcomment = Pcomment.find(params[:id])
  end

  def pcomment_params
    params.require(:pcomment).permit(:comment).merge(user_id: current_user.id, practice_id: params[:practice_id])
  end

  def move_to_root
    redirect_to root_path unless @pcomment.user_id == current_user.id
  end
end
