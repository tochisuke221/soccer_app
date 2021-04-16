class LikesController < ApplicationController
  before_action :authenticate_user!,only:[:create,:destroy]

  def create
    
    @practice=Practice.find(params[:practice_id])
    like = current_user.likes.new(practice_id: @practice.id)
    like.save
    # redirect_to  root_path
    
  end
  
  def destroy
    @practice=Practice.find(params[:practice_id])
    like = Like.find_by(practice_id: params[:practice_id], user_id: current_user.id)
    like.destroy
    # redirect_to  root_path
  end
end
