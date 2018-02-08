ActiveAdmin.register Application do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  scope "Registro de marcas", :brands
  scope "Patentes y diseños", :patents
  scope "Derechos de autor", :copyrights

  filter :status, as: :select, collection: Application.statuses_t

  index do
    selectable_column
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
  end
end
