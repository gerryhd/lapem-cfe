class Applicant::ApplicationsController < ApplicationController

  let :applicant, :all

  before_action :set_application, only: [:show, :destroy, :update]

  def index
  end

  def create
  end

  def update
  end

  def show
  end

  def destroy
    if @application.destroy
      render json: {status: true}
    else
      render json: {status: false, errors: @application.errors.full_messages}
    end
  end

  private
  def set_application
    @application = Application.find(params[:id])
  end
end
