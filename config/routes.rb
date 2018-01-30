Rails.application.routes.draw do
  root 'application#index'

  localized do
    get 'login' => 'login#new'
    post 'login' => 'login#create'
    get 'logout' => 'login#destroy'

    namespace :admin do
      get 'index' => 'index#index'
    end

    scope module: 'applicant' do
      get 'index' => 'index#index', as: 'applicant_index'
      get 'register' => 'index#new', as: 'new_applicant'
      post 'register' => 'index#create'
    end
    
  end

end
