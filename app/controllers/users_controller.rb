class UsersController < ApplicationController
  before_action :authenticate_user!,only:[:show,:edit,:update]
  before_action :set_user,only:[:show,:edit,:update,:update,:destroy]
  before_action :profile_is_yourself?,only:[:edit,:update]
  before_action :ensure_normal_user,only:[:update,:destroy]
  
  

  def show
    @mylike_practices=User.find(params[:id]).liked_practices
    @mypost_practices=Practice.where(user_id:params[:id])
    @my_follows=User.find(params[:id]).followings
    @my_followed=User.find(params[:id]).followers
    if current_user.following?(@user)
      @relation=Relationship.find_by(user_id:current_user.id,follow_id:@user.id)
    end
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

  def destroy
    @user.destroy
    flash[:notice]="退会処理を完了しました。再度ログインする場合は新規登録をしてください"
    redirect_to root_path
  end

  private

  def edit_params
    params.require(:user).permit(:name,:team_name,:career_id,:phone_num,:myphoto)
  end

  def set_user
    binding.pry
    @user=User.find(params[:id])
  end
  def profile_is_yourself?
    unless @user.id==current_user.id
      redirect_to user_path(@user)
    end
  end
  def ensure_normal_user
    if @user.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの更新・削除はできません。'
    end
  end
end
