Rails.application.routes.draw do
  root 'application#index'

  localized do
    get 'login' => 'login#new'
    post 'login' => 'login#create'
    get 'logout' => 'login#destroy'
    get 'index' => 'application#index'
    
  end

end
