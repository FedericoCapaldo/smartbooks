module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token #permanent sets the expiry date 20 years from now
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  # self.current_user = ...   ===  current_user=(....)
  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user?(user)
    user == current_user # current_user being the method above
  end


  def store_location
    session[:return_to] = request.fullpath
  end

  def return_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

end