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
    if admin?
      redirect_to admin_root_path and return
    end

    if applicant?
      redirect_to applicant_index_path and return
    end

    raise "No admin or applicant present after log in"
  end

  def admin?
    current_user.type_user.id == TypeUser::ADMIN
  end

  def applicant?
    current_user.type_user.id == TypeUser::APPLICANT
  end
end