ActiveAdmin.register Applicant do
  permit_params :email, user_attributes: [:username, :password, :password_confirmation]


  form do |f|
    f.inputs 'Solicitante' do
      input :email
      f.has_many :user, heading: 'Usuario', new_record: false, allow_destroy: false do |s|
        s.input :username
        s.input :password
        s.input :password_confirmation
  
      end
    end
    
    f.actions

  end
  controller do
    let :admin, :all

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
        redirect_to action: :index and return
      else
        @errors = @applicant.errors.full_messages
      end

      render :new
    end

    def applicant_params
      permitted_params[:applicant]
    end

    def user_params
      applicant_params[:user_attributes]
    end

  end
end
