Rails.application.routes.draw do
  root to: redirect('/index')

  localized do
    get 'login' => 'login#new'
    post 'login' => 'login#create'
    get 'logout' => 'login#destroy'
  end

end
