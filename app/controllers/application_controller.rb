class ApplicationController < ActionController::API
	include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  
  before_action :configure_permitted_parameters, if: :devise_controller?

	protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role, :name, :profile_pic])
  end
end
