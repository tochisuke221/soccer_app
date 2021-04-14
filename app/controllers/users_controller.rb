class UsersController < ApplicationController
  before_action :set_user,only:[:show,:edit,:update]
  before_action :authenticate_user!,only:[:show,:edit,:update]
  before_action :profile_is_yourself?,only:[:edit,:update]

  def show
  end
  
  def edit
  end
  
  def update
    if @user.update(edit_params)
      redirect_to user_path(@user)
    else 
      render :edit
    end
  end


  private

  def edit_params
    params.require(:user).permit(:name,:team_name,:career_id,:phone_num,:myphoto)
  end

  def set_user
    @user=User.find(params[:id])
  end
  def profile_is_yourself?
    unless @user.id==current_user.id
      redirect_to user_path(@user)
    end
  end
end
