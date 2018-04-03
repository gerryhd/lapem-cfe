Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'login#new'


  get 'login' => 'login#new'
  post 'login' => 'login#create'
  get 'logout' => 'login#destroy'


  namespace :applicant do
    get 'index' => 'index#index'
    resources :applications do
      collection do
        get 'general_information'
        get 'new' => 'applications#new'
        get '/:id' => 'applications#show'
        get '/:id/edit' => 'applications#edit'
      end
    end
  end

  get '/admin/users/new/quick_add' => 'admin/users#quick_add', as: :admin_applicant_quick_add
  post '/admin/users/quick_create' => 'admin/users#quick_create', as: :admin_applicant_quick_create
  post '/admin/applications/:id/comment' => 'admin/applications#create_observation', as: :admin_observation_create
  get '/admin/applications/:id/approve' => 'admin/applications#approve', as: :admin_application_approve
  get '/admin/applications/:id/reject' => 'admin/applications#reject', as: :admin_application_reject

  get "/proof_files/:id/:basename.:extension" => 'admin/applications#download_file'
end
