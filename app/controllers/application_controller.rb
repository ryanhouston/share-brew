class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def require_authentication
    unless user_signed_in?
      flash[:error] = "You must be logged in to perform this action"
      redirect_to new_user_session_path
    end
  end

end
