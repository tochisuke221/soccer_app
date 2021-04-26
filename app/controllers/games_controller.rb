class GamesController < ApplicationController
  
  def index
  end
  
  def show
  end
  
  def new
    @game=Game.new
  end
  
  def create
   
    @game=Game.new(game_params)
    if @game.save
      flash[:notice]="募集に成功しました"
      redirect_to root_path
    else
      flash[:alert]="募集投稿に失敗しました"
      render :new
    end
  end

  def destroy
  end

  private
  
  def game_params
    params.require(:game).permit(:title,:gameday,:location,:gamenum_id,:gametime_id,:level_id,:description).merge(user_id:current_user.id)
  end
end
