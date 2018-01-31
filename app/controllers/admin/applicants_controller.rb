class Admin::ApplicantsController < ApplicationController
  let :admin, :all


  # Catálogo de usuarios solicitantes
  def index
    @applicants = Applicant.all
  end

  def new
    @applicant = Applicant.new
    @applicant.user = User.new
  end

  def create
    @applicant = Applicant.new(applicant_params)
    @applicant.user = User.new(user_params)
    @applicant.user.type_user = TypeUser.find(TypeUser::APPLICANT)

    if @applicant.save
      flash[:success] = "Object successfully created"
    else
      flash[:error] = "Something went wrong"
      @errors = @applicant.errors.full_messages
    end

    render :new
  end

  private

  def applicant_params
    params.require(:applicant).permit(:email)
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
  
end