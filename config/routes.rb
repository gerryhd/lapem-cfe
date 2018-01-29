Rails.application.routes.draw do
  root to: redirect('/index')

  localized do
    get 'login' => 'login#new'
    post 'login' => 'login#create'
    get 'logout' => 'login#destroy'
    get 'index' => 'application#index'
  end

end
