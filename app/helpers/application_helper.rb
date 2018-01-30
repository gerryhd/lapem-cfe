module ApplicationHelper
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find_by(id: user_id)
  end
end
