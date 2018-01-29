module LoginHelper
  def logged_in?
    !current_user.nil?
  end

  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find_by(id: user_id)
  end

  def log_in(user)
    session[:user_id] = user.id
    session[:user_role] = user.type_user.name
    current_user
  end

  def log_out
    session.delete(:user_id)
    session.delete(:user_role)
    @current_user = nil
  end

  def enter
    if administrator?
      render html: 'you are an admin'
    end

    if applicant?
      render html: 'you are an applicant'
    end

  end

  def administrator?
    current_user.type_user.id == TypeUser::ADMIN
  end

  def applicant?
    current_user.type_user.id == TypeUser::APPLICANT
  end
end