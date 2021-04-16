class PcommentsController < ApplicationController
  def create
    @pcomment=Pcomment.new(pcomment_params)
    @practice=Practice.find(params[:practice_id])  
    if @pcomment.save
      redirect_to practice_path(@practice)
    else
      render "practices/show"
    end
  end
  
  private
  def pcomment_params
    params.require(:pcomment).permit(:comment).merge(user_id:current_user.id,practice_id:params[:practice_id])
  end
end
