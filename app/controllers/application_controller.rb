class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  private
  def require_authentication
    unless user_signed_in?
      flash[:error] = "You must be logged in to perform this action"
      redirect_to new_user_session_path
    end
  end

  def authenticate
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV["SHAREBREW_USER"] && password == ENV["SHAREBREW_PASSWD"]
      end
    end
  end

end
