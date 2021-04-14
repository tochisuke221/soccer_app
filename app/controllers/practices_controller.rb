class PracticesController < ApplicationController
  
  def index
    @practices=Practice.all
  end

  def new
    @practice=Practice.new
  end


  def create 
    @practice=Practice.new(new_params)

    if @practice.save
      redirect_to root_path
    else
      render :new
    end

  end

  private
  def new_params
    params.require(:practice).permit(:title,:content,:hardlevel_id,:category_id,images: []).merge(user_id:current_user.id)
  end
end
