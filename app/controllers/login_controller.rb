class LoginController < ApplicationController
  let :all, :all
  include LoginHelper

  def new
    if logged_in?
      enter
    else
      render :new, layout: false
    end
  end

  def create
    user = User.authenticate(params[:session][:username], params[:session][:password])
    if user
      log_in user
      enter
    else
      flash[:notice] = "Usuario o contraseña incorrectas"
      redirect_to root_path
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end