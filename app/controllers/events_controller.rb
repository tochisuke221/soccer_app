class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :your_schedule?
  before_action :set_events, only: [:index, :create]

  def index
    @add_event = Event.new
  end

  def create
    @add_event = Event.new(event_params)
    if @add_event.save
      redirect_to user_events_path(current_user)
    else
      render :index
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to user_events_path(current_user)
  end

  private

  def event_params
    params.require(:event).permit(:title, :content, :start_time).merge(user_id: current_user.id)
  end

  def your_schedule?
    redirect_to user_path(current_user) unless current_user.id == params[:user_id].to_i
  end

  def set_events
    @events = Event.where(user_id: current_user.id).order(start_time: 'ASC')
  end
end
