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
      application.application_type.name_t
    end
    column "Creado el", :created_at

    actions
  end

  
  controller do
    let :admin, :all

    def scoped_collection
      query = params[:search]
      
      

      if query.blank?
        super
      else
        # If query matches any of the statuses, return the scope
        (I18n.t :status).each do |k,s|
          if s.casecmp(query) == 0
            status = s
            query_is_status = true
            return eval("super.#{k.to_s}")
          end
        end
  
        super.joins(:applicant).joins(:user).where('name LIKE :search OR last_name LIKE :search OR name LIKE :search OR last_name LIKE :search', search: "%#{params[:search]}%")
      end
    end
  end
end
