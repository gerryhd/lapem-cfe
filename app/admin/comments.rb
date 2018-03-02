ActiveAdmin.after_load do
  ActiveAdmin.register ActiveAdmin::Comment, as: 'Comment' do
    controller do
      let [:admin, :applicant], :all
    end
  end
end