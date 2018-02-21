ActiveAdmin.register Applicant do
  permit_params :email, :name, :last_name, user_attributes: [:username, :password, :password_confirmation]
  
  actions :index, :show, :update, :edit

  index do
    column :email
    column :user
    column :name
    column :last_name

    actions
  end

  action_item only: :index do
    link_to 'Nuevo', admin_applicant_quick_add_path, class: 'fancybox', data: { 'fancybox-type' => 'ajax' }
  end


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

    def scoped_collection
      query = params[:search]
      
      if query.blank?
        super
      else
        super.joins(:user).where('username LIKE :search OR email LIKE :search OR name LIKE :search OR last_name LIKE :search', search: "%#{params[:search]}%")
      end
    end

    def quick_add
      @applicant = Applicant.new
      @applicant.user = User.new
      render layout: false
    end

    def quick_create
      @applicant = Applicant.new(applicant_params)
      @applicant.user = User.new(user_params)
      @applicant.user.type_user = TypeUser.find(TypeUser::APPLICANT)


      respond_to do |format|
        if @applicant.save
          flash[:success] = "El usuario solicitante ha sido creado"
          format.html { render :action => 'quick_add' }
          format.js { render :action => 'quick_response' }
        else
          @errors = @applicant.errors.full_messages
          flash.now[:error] = @errors
          format.html { render :action => 'quick_add' }
          format.js { render :action => 'quick_response' }
        end
      end
      
      
    end

    def edit
      @applicant = Applicant.find(params[:id])
    end

    def update
      @applicant = Applicant.find(params[:id])
      applicant_data = applicant_params

      applicant_data[:user_attributes] = user_params.reject{|_, v| v.blank?}
      applicant_data[:user_attributes][:id] = @applicant.user.id
      applicant_data[:user_attributes][:change_password] = true if user_params[:password].present?

      if @applicant.update(applicant_data)
        flash[:success] = "La información del solicitante se actualizó correctamente"
        redirect_to action: :show and return
      else
        @errors = @applicant.errors.full_messages
        flash[:error] = @errors
        byebug
      end

      render :edit
    end

    def applicant_params
      permitted_params[:applicant]
    end

    def user_params
      applicant_params[:user_attributes]
    end
  end
end
