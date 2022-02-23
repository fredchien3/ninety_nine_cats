class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  private
  def require_no_user!
    redirect_to cats_url if current_user
  end

  def current_user
    user = User.find_by(session_token: session[:session_token])
    user ? user : nil
  end

  def log_in!(user)
    user.reset_session_token!
    self.session[:session_token] = user.session_token
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out!
    current_user.reset_session_token!
    self.session[:session_token] = nil
  end

  def require_user!
    redirect_to new_session_url if current_user.nil?
  end

end
