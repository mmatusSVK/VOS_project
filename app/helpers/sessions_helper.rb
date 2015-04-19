module SessionsHelper

  def log_in_new_user(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= find_by_session_id(session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out_current_user
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    user == current_user
  end

  private

  def find_by_session_id(id)
    user = User.find(id)
  end
end
