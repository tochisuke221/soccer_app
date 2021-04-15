class PracticesController < ApplicationController
  
  def index
    @practices=Practice.includes(:user).order("created_at DESC")
  end

  def show
    @practice=Practice.find(params[:id])
  end

  def new
    @practice=Practice.new
  end


  def create 
    @practice=Practice.new(practice_params)
    if @practice.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @practice=Practice.find(params[:id])
  end
  
  def update
    @practice=Practice.find(params[:id])
    if @practice.update(practice_params)
      redirect_to practice_path(@practice)
    else
      render :edit
    end
  end
  

  private
  def practice_params
    params.require(:practice).permit(:title,:content,:hardlevel_id,:category_id,:image).merge(user_id:current_user.id)
  end
end
