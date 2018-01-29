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
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user
      log_in user
      enter
    else
      flash[:notice] = I18n.t('public.login.unauthorized')
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to index_path
  end
end