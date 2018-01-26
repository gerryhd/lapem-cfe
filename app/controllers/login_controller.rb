class LoginController < ApplicationController
  let :all, :action_controller
  include LoginHelper

  def new
    if logged_in?
      enter
    else
      render action: 'new', layout: false
    end
  end

  def create
    user = User.authenticate(params[:session][:email], params[:session][:passowrd])
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