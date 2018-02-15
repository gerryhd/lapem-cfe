class Applicant::IndexController < ApplicationController
  include LoginHelper

  let :applicant, [:index]
  let :all, [:new, :create]

  before_filter :check_if_logged, only: [:new, :create]

  def index
    # @applications = current_user.applicant.applications.all
    render html: "#{flash[:success] or flash[:error]} \n This is the index for applicants"
  end


  # These won't be used for now as registration of applicants is performed
  # by admin users
=begin
  def new
    @applicant = Applicant.new
    @applicant.user = User.new

    render :new
  end

  def create
    @applicant = Applicant.new(applicant_params)
    @applicant.user = User.new(user_params)
    @applicant.user.type_user = TypeUser.find(TypeUser::APPLICANT)

    if @applicant.save
      flash[:success] = "Object successfully created"
      @applicant.reload
      log_in(@applicant.user)
      enter
    else
      flash[:error] = "Something went wrong"
      @errors = @applicant.errors.full_messages + @applicant.user.errors.full_messages
      render 'new'
    end
  end
=end
  
  
  private 

  def check_if_logged

    if current_user.present?
      redirect_to applicant_index_path and return
    end
    
  end

  def applicant_params
    params.require(:applicant).permit(:email)
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
