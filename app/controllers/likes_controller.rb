class LikesController < ApplicationController
  before_action :authenticate_user!,only:[:create,:destroy]

  def create
    #いいねの作成
    @practice=Practice.find(params[:practice_id])
    like = current_user.likes.new(practice_id: @practice.id)
    like.save
    #いいね通知の作成
    @practice.create_notification_by(current_user)
    
    
  end
  
  def destroy
    @practice=Practice.find(params[:practice_id])
    like = Like.find_by(practice_id: params[:practice_id], user_id: current_user.id)
    like.destroy
    # redirect_to  root_path
  end
end
