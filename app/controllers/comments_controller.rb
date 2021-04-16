class CommentsController < ApplicationController

  def create
    @pcomment=pcomment.new(pcomment_params)  
    if @pcomment.save
      redirect_to root_path
    else
      render "practice/show"
    end
  end
  
  private
  def pcomment_params
    params.require(:pcomment_params).permit(:comment).merge(user_id:params[:id],practice_id:params[:practice_id])
  end
end
