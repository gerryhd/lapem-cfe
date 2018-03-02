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
    
  get '/admin/applicants/new/quick_add' => 'admin/applicants#quick_add', as: :admin_applicant_quick_add
  post '/admin/applicants/quick_create' => 'admin/applicants#quick_create', as: :admin_applicant_quick_create

end
