PaperclipOnHeroku::Application.routes.draw do
  devise_for :users, :path_names => { :sign_in => 'login' }
  # omniauth:
  match '/auth/:provider/callback' => 'authentications#create'  
  
  resources :users, :path => 'hitchhikers'

  resources :trips do
    resources :hitchhikes, :except => [:index]
  end
  
  resources :hitchhikes, :except => [:index] do
    member{ delete 'delete_photo' }
  end
  
  match 'hitchhikers' => 'users#index'
  match 'about' => 'welcome#about'
  match 'hitchhikes.json' => 'hitchhikes#json'

  root :to => "welcome#home"
end
