class LikesController < ApplicationController

  def create
    @like = current_user.likes.create(practice_id: params[:practice_id])
    redirect_to  root_path
  end

  def destroy
    @like = Like.find_by(practice_id: params[:practice_id], user_id: current_user.id)
    @like.destroy
    redirect_to  root_path
  end
end
