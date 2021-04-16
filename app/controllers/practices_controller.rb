class PracticesController < ApplicationController
  before_action :set_practice,only:[:show,:update,:destroy,:edit]
  before_action :authenticate_user!,only:[:new,:show,:edit,:create,:update,:destroy]
  before_action :move_to_root,only:[:edit,:update,:destroy]

  def index
    @practices=Practice.includes(:user).order("created_at DESC")
    @like = Like.new
  end

  def show
    @pcomment=Pcomment.new
    @pcomments=Pcomment.all
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
  end
  
  def update
    if @practice.update(practice_params)
      redirect_to practice_path(@practice)
    else
      render :edit
    end
  end
  
  def destroy
    @practice.destroy
    redirect_to root_path
  end

  private
  def practice_params
    params.require(:practice).permit(:title,:content,:hardlevel_id,:category_id,:image).merge(user_id:current_user.id)
  end

  def set_practice
    @practice=Practice.find(params[:id])
  end

  def move_to_root 
    unless @practice.user.id==current_user.id
      redirect_to root_path
    end
  end
end
