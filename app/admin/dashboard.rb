ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: "Inicio"

  content title: "Inicio" do
    panel "Estadísticas de solicitudes por estado" do
      pie = Hash.new
      StatusApplication.all.each do |status|
        pie[status.name] = Application.where(status_application_id: status.id).count
      end
      pie_chart pie
    end

    panel "Estadísticas de solicitudes por tipo" do
      pie = Hash.new
      ApplicationType.all.each do |type|
        pie[type.name] = Application.where(application_type_id: type.id).count
      end
      pie_chart pie
    end
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content

  controller do
    let :admin, :all
  end
end
