ActiveAdmin.register Application do
  menu label: "Solicitudes"
  permit_params :observation

  actions :index, :show

  scope "Todas", :all, default: true
  scope "Marcas, Avisos y Nombres Comerciales", :brands
  scope "Patentes, Registro de Modelo de Utilidad y Registro de Diseño Industrial", :patents
  scope "Derechos de autor", :copyrights


  index title: "Solicitudes" do
    column 'Solicitante', :applicant do |application|
      link_to application.applicant.full_name, admin_user_path(application.applicant.user_id)
    end
    column 'Estado', :status do |application|
      application.status_application.name
    end
    column 'Tipo de solicitud', :application_type do |application|
      application.application_type.name
    end
    column "Creado el", :created_at

    actions
  end

  show title: proc{"Solicitud ##{resource.id}"} do
    panel "Datos de la solicitud" do
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
        StatusApplication.all.each do |status|
          if status.name.casecmp(query) == 0
            return super.where(status_application_id: status.id)
          end
        end
        super.joins(:applicant).where('name LIKE :search OR last_name LIKE :search', search: "%#{params[:search]}%")
      end
    end

    def reject
      application = Application.find(params[:id])
      application.status_application_id = StatusApplication::REJECTED
      application.save
      redirect_to admin_application_path(application)
    end

    def approve
      application = Application.find(params[:id])
      application.status_application_id = StatusApplication::APPROVED
      application.save
      redirect_to admin_application_path(application)
    end

    def create_observation
      observation = observation_params
      # Ensure comment is for current application from show and from current user
      if params[:id] == observation[:application_id] && current_admin_user.id == observation[:user_id].to_i
        observation = Observation.create(observation)
        app = Application.find(observation[:application_id])
        app.status_application_id = StatusApplication::OBSERVATIONS if app.status_application_id == StatusApplication::PENDING
        app.save
      else
        flash[:error] = "Error al hacer comentario: Las IDs no concuerdan"
      end

      redirect_to admin_application_path(observation.application_id)
    end

    def observation_params
      params.require(:observation).permit(:notes, :application_id, :user_id)
    end
  end
end
