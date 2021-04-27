class EventsController < ApplicationController

  before_action :authenticate_user!
  before_action :your_schedule?

  def index
    @events=Event.where(user_id:current_user.id).order(start_time: "ASC")
    @add_event=Event.new
  end

  def create
    Event.create(event_parameter)
    redirect_to user_events_path(current_user)
  end

  def destroy
    @event=Event.find(params[:id])
    @event.destroy
    redirect_to user_events_path(current_user)
  end

  private

  def event_parameter
    params.require(:event).permit(:title, :content, :start_time).merge(user_id:current_user.id)
  end

  def your_schedule?
    unless current_user.id ==params[:user_id].to_i
      redirect_to user_path(current_user)
    end
  end

end
