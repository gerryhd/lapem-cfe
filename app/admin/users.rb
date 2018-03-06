ActiveAdmin.register User do
  menu label: "Solicitantes"
  permit_params :username, :password, :password_confirmation, :change_password, applicant_attributes: [:email, :name, :last_name]
  
  actions :index, :show, :update, :edit

  index do
    column :email do |user|
      user.applicant.email
    end
    column :username
    column :name do |user|
      user.applicant.name
    end
    column :last_name do |user|
      user.applicant.last_name
    end
    actions
  end

  action_item only: :index do
    link_to 'Nuevo', admin_applicant_quick_add_path, class: 'fancybox', data: { 'fancybox-type' => 'ajax' }
  end


  form do |f|
    f.inputs 'Solicitante' do
      input :username
      f.inputs class: "change_password" do
        f.input :change_password, label: 'Cambiar contraseña', as: :boolean
      end
      f.inputs class: "password_fields" do
        input :password
        input :password_confirmation
      end
      f.has_many :applicant, new_record: false, allow_destroy: false do |a|
        a.input :email
        a.input :name
        a.input :last_name
      end

    end
    
    f.actions

  end
  controller do
    let :admin, :all

    def scoped_collection
      collect = super.where.not(type_user_id: TypeUser::ADMIN)
      query = params[:search]
      
      if query.blank?
        collect
      else
        collect.joins(:applicant).where('username LIKE :search OR email LIKE :search OR name LIKE :search OR last_name LIKE :search', search: "%#{params[:search]}%")
      end
    end

    def quick_add
      @user = User.new
      @user.applicant = Applicant.new

      render layout: false
    end

    def quick_create

      @user = User.new(user_params)
      @user.applicant = Applicant.new(applicant_params)
      @user.type_user = TypeUser.find(TypeUser::APPLICANT)


      respond_to do |format|
        if @user.save
          flash[:success] = "El usuario solicitante ha sido creado"
          format.html { render :action => 'quick_add' }
          format.js { render :action => 'quick_response' }
        else
          @errors = @user.errors.full_messages
          flash.now[:error] = @errors
          format.html { render :action => 'quick_add' }
          format.js { render :action => 'quick_response' }
        end
      end
      
      
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      applicant_data = applicant_params
      user_data = user_params.reject{|_, v| v.blank?}

      user_data[:applicant_attributes] = applicant_data.reject{|_, v| v.blank?}
      user_data[:applicant_attributes][:id] = @user.applicant.id
      user_data[:change_password] = (user_data[:change_password] == "1")

      if @user.update(user_data)
        flash[:success] = "La información del solicitante se actualizó correctamente"
        redirect_to action: :show and return
      else
        @errors = @user.errors.full_messages
        flash[:error] = @errors
      end

      render :edit
    end

    def applicant_params
      user_params[:applicant_attributes]
    end

    def user_params
      permitted_params[:user]
    end
  end
end