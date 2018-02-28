ActiveAdmin.register Application do

  actions :index, :show

  scope "Registro de marcas", :brands
  scope "Patentes y diseños", :patents
  scope "Derechos de autor", :copyrights

  filter :status, as: :select, collection: Application.statuses_t, filters: ['eq']

  index do
    column :applicant do |application|
      link_to application.applicant.full_name, admin_applicant_path(application.applicant.id)
    end
    column :status do |application|
      I18n.t("status.#{application.status.to_s}")
    end
    column :application_type do |application|
      application.application_type.name
    end
    column "Creado el", :created_at

    actions defaults: true do |app|
      text_node link_to "Aprobar", approve_admin_application_path(app), method: :put, class: "member_link" if app.pending?
      text_node link_to "Rechazar", reject_admin_application_path(app), method: :put, class: "member_link" if app.pending?
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
    attributes_table do
      row :applicant
      row :status do |app|
        I18n.t("status.#{app.status.to_s}")
      end
      row :application_type
    end

    panel "Detalles del Solicitante" do
      attributes_table_for application.applicant do
        row :date do
          application.created_at.to_date
        end
        row :curp
        row :name
        row :first_last_name
        row :second_last_name
        row :nationality
        row :phone
        row :email
        row :zip_code
        row :street
        row :ext_num
        row :int_num
        row :zone_name
        row :municipality
      end

    end

    if application.application_type_id == ApplicationType::BRAND

      panel "Signo Distintivo" do
        application.proof_files.each do |image|
          span do
            image_tag image.url
          end
        end
      end
      
      panel "Registro de Marca" do
        attributes_table_for application.brand do
          row :brand_type
          row :sign_type
        end
      end

      panel "Persona" do
        person = application.brand.person
        
        if person.instance_of? NaturalPerson
          h1 "Persona física"
          # attributes_table_for person do
          #   row :date
          #   row :name
          #   row :last_name
          #   row :second_last_name
          #   row :nationality
          #   row :phone_number
          #   row :email
          # end
        elsif person.instance_of? LegalPerson
          h1 "Persona moral"
          attributes_table_for person do
            row :date
            row :denomination
            row :rfc
            row :phone_number
            row :email
          end
        end
        
      end
    
    elsif application.application_type_id == ApplicationType::PATENT

      panel "Patente" do
        attributes_table_for application.patent do
          row :title
          row :divulgation_date
        end
      end

    elsif application.application_type_id == ApplicationType::COPYRIGHT

      panel "Derechos de Autor" do
        attributes_table_for application.copyright do
          row :title
          row :summary
        end
      end

    end
    active_admin_comments
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
  end
end
