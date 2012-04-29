Hitchlog::Application.routes.draw do
  devise_for :users, :path_names => { :sign_in => 'login' },
                     :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # omniauth:
  match '/auth/:provider/callback' => 'authentications#create'  
  match '/random_photo' => 'rides#random_photo'  
  
  resources :users, :path => 'hitchhikers' do
    member do 
      get 'send_mail'
      post 'mail_sent'
    end
  end

  resources :trips do
    resources :rides, :except => [:index] 
    member do
      post 'create_comment'
    end
  end
  
  resources :rides, :except => [:index] do
    member{ delete 'delete_photo' }
  end
  
  match 'hitchhikers' => 'users#index'
  match 'about' => 'welcome#about'

  root :to => "welcome#home"
end
