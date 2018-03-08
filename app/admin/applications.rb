ActiveAdmin.register Application do
  permit_params :observation

  actions :index, :show

  scope "Todas", :all, default: true
  scope "Marcas, Avisos y Nombres Comerciales", :brands
  scope "Patentes, Registro de Modelo de Utilidad y Registro de Diseño Industrial", :patents
  scope "Derechos de autor", :copyrights


  index do
    column :applicant do |application|
      link_to application.applicant.full_name, admin_user_path(application.applicant.user_id)
    end
    column :status do |application|
      application.status_application.name
    end
    column :application_type do |application|
      application.application_type.name
    end
    column "Creado el", :created_at

    actions defaults: true do |app|
      if app.status_application_id == StatusApplication::PENDING
        text_node link_to "Aprobar", approve_admin_application_path(app), method: :put, class: "member_link"
        text_node link_to "Rechazar", reject_admin_application_path(app), method: :put, class: "member_link"
      end
    end
  end

  member_action :approve, method: :put do
    resource.approved!
    flash[:success] = "La aplicación fue aprobada."

    redirect_to admin_applications_path
  end

  member_action :reject, method: :put do
    resource.rejected!
    flash[:success] = "La aplicación ha sido rechazada."

    redirect_to admin_applications_path
  end

  show do
    panel "Datos generales del o de los solicitantes" do
      render 'show', {application: application}
    end

    panel "Observaciones" do
      render 'observations', {application: application, observation: Observation.new}
    end
  end

  controller do
    let :admin, :all

    def scoped_collection
      query = params[:search]

      if query.blank?
        super
      else

        # If query matches any of the statuses, return the collection scoped to said status
        (I18n.t :status).each do |k,s|
          if s.casecmp(query) == 0
            status = s
            query_is_status = true
            return eval("super.#{k.to_s}")
          end
        end
  
        super.joins(:applicant).where('name LIKE :search OR last_name LIKE :search OR name LIKE :search OR last_name LIKE :search', search: "%#{params[:search]}%")
      end
    end

    def create_observation
      observation = observation_params
      # Ensure comment is for current application from show and from current user
      if params[:id] == observation[:application_id] && current_admin_user.id == observation[:user_id].to_i
        observation = Observation.create(observation)
      else
        flash[:error] = "Error al hacer comentario: Las IDs no concuerdan"
      end

      redirect_to admin_application_path(observation.application_id)
    end

    def download_file
      path = "#{Rails.root}/private/proof_files/#{file_params[:id]}/#{file_params[:basename]}.#{file_params[:extension]}"
      send_file path, :x_sendfile=>true
    end

    private

    def file_params
      params.permit(:id, :basename, :extension)
    end

    def observation_params
      params.require(:observation).permit(:notes, :application_id, :user_id)
    end
  end
end
