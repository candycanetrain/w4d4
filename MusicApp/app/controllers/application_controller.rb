class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user, :log_out!

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def log_in_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def logged_in?
    !!current_user
  end

  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

end
