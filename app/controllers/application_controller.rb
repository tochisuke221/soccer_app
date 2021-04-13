class ApplicationController < ActionController::Base
<<<<<<< Updated upstream
=======
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:team_name,:career_id,:phone_num,:myphoto])
  end
>>>>>>> Stashed changes
end
