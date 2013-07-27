Hitchlog::Application.routes.draw do
  devise_for :users, path_names: { :sign_in => 'login' }, path: 'hitchhikers'

  filter :locale

  match 'auth/:provider/callback', to: 'omniauth#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  # omniauth:

  resources :future_trips, except: [:show]

  resources :users, :path => 'hitchhikers' do
    member do
      get :geomap
      get :send_mail
      post :mail_sent
    end
  end

  resources :trips do
    resources :rides, :except => [:index]
    member do
      post :create_comment
    end
  end

  resources :rides, :except => [:index] do
    collection do
      get    :random
    end
    member do
      get    :next
      get    :prev
      delete :delete_photo
    end
  end

  match 'hitchhikers' => 'users#index'
  match 'home' => 'welcome#home'
  match 'about' => 'welcome#about'
  match 'bootstrap' => 'welcome#bootstrap'

  # making static crisp html templates available to see if they are displayed correctly
  match 'crisp/:action', controller: :crisp if Rails.env == 'development'

  root to: "welcome#home"

  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
end
