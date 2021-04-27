class EventsController < ApplicationController
  def index
    @events=Event.where(user_id:current_user.id)
  end

  def new
    @event=Event.new
  end

end
