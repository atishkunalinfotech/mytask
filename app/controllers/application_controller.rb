class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  helper_method :current_user

  def after_sign_in_path_for(current_user)
    tasks_path
  end

  
  def current_user
   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  protected
  
  def permission_denied
    flash[:error] = "Sorry, you are not allowed to access this page."
    redirect_to root_url
  end
end


