class ApplicationController < ActionController::Base
  before_action :basic_auth if Rails.env.production?
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :team_name, :career_id, :phone_num, :myphoto])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :team_name, :career_id, :phone_num, :myphoto])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']  # 環境変数を読み込む記述に変更
    end
  end
end
