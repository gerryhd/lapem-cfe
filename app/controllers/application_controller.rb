class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  let :all, :all
  include LoginHelper

  def index
    if current_user.blank?
      render html: "you are in the public landing page", layout: true
    elsif current_user.type_user.id == TypeUser::ADMIN
      redirect_to admin_index_path
    elsif current_user.type_user.id == TypeUser::APPLICANT
      redirect_to applicant_index_path
    end

  end

  # Esto es usado por la autentificación de active_admin
  def authenticate_admin!
    redirect_to root_path unless current_user.admin?
  end

  def current_admin_user
    current_user if current_user.type_user.id == TypeUser::ADMIN
  end
  
end
