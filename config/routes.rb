Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'login#new'


  get 'login' => 'login#new'
  post 'login' => 'login#create'
  get 'logout' => 'login#destroy'


  namespace :applicant do
    get 'index' => 'index#index'
    resources :applications
  end
    
  get '/admin/users/new/quick_add' => 'admin/users#quick_add', as: :admin_applicant_quick_add
  post '/admin/users/quick_create' => 'admin/users#quick_create', as: :admin_applicant_quick_create
  post '/admin/applications/:id/comment' => 'admin/applications#create_observation', as: :admin_observation_create

  get "/proof_files/:id/:basename.:extension" => 'admin/applications#download_file'
end
