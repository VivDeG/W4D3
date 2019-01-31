class ApplicationController < ActionController::Base
  helper_method :current_user

  def login!(user)
    debugger
    @current_user = user
    session[:session_token] = user.session_token
  end

  def current_user
    debugger
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
    debugger
  end

  def logout!
    debugger
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
  end

  def logged_in?
    debugger
    !!current_user
  end

  def require_current_user!
    debugger
    redirect_to new_session_url if current_user.nil?
  end
end
