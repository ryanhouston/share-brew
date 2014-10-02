class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def require_authentication
    unless user_signed_in?
      flash[:error] = "You must be logged in to perform this action"
      redirect_to new_user_session_path
    end
  end
end

