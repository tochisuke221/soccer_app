class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :index]
  before_action :set_game, only: [:show, :challenge, :destroy]
  before_action :are_you_host?, only: [:destroy]

  def index
    @games = Game.includes(:user).order(created_at: 'DESC').where(check: false).page(params[:page]).per(5)
  end

  def show
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:notice] = '募集に成功しました'
      redirect_to games_path
    else
      flash[:alert] = '募集投稿に失敗しました'
      render :new
    end
  end

  def destroy
    @game.destroy
    flash[:notice] = '募集の削除をしました'
    redirect_to games_path
  end

  def challenge
    @game.check = true
    @game.save
    flash[:notice] = '申し込みを完了しました!!!開催者にDMを送りましょう'
    redirect_to user_path(@game.user_id)
  end

  private

  def game_params
    params.require(:game).permit(:title, :gameday, :location, :gamenum_id, :gametime_id, :level_id,
                                 :description).merge(user_id: current_user.id)
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def recruiting
    redirect_to games_path if @game.check
  end

  def are_you_host?
    redirect_to games_path unless current_user.id == @game.user_id
  end
end
