class EventsController < ApplicationController
  def index
    @events=Event.where(user_id:current_user.id)
  end
end
