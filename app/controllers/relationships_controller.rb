class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  
  def create

    @other_user=User.find(params[:user_id])
    following = current_user.follow(@other_user)
    if following.save
      flash[:notice]="#{@other_user.name}をフォローしました"
      #redirect_to user_path(other_user)
      @relation=Relationship.find_by(user_id:current_user.id,follow_id:@other_user.id)
    else
      flash[:alert]="フォローに失敗しました"
      #redirect_to user_path(other_user)  
    end
  end
  
  def destroy
   
    @other_user=User.find(params[:user_id])
    following = current_user.unfollow(@other_user)
    if following.destroy
      flash[:notice] = "#{@other_user.name}フォローを解除しました"
       # redirect_to user_path(other_user)
    else
      flash.now[:alert] = 'フォロー解除に失敗しました'
      #redirect_to user_path(other_user)
    end
  end
end
