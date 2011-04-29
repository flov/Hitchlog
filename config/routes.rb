Hitchlog::Application.routes.draw do
  devise_for :users, :path_names => { :sign_in => 'login' },
                     :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # omniauth:
  match '/auth/:provider/callback' => 'authentications#create'  
  
  resources :users, :path => 'hitchhikers'

  resources :trips do
    resources :rides, :except => [:index]
  end
  
  resources :rides, :except => [:index] do
    member{ delete 'delete_photo' }
  end
  
  match 'hitchhikers' => 'users#index'
  match 'about' => 'welcome#about'

  root :to => "welcome#home"
end
