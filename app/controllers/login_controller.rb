class LoginController < ApplicationController
  let :all, :all
  include LoginHelper

  def new
    if logged_in?
      enter
    else
      render :new
    end
  end

  def create
    user = User.authenticate(params[:session][:username], params[:session][:password])
    if user
      log_in user
      enter
    else
      render html: I18n.t('public.login.unauthorized')
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end