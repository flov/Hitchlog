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
      get :trips
      get :geomap
      get :send_mail
      post :mail_sent
    end
  end

  resources :trips do
    resources :rides, only: [:create, :update, :destroy]
    member do
      post :create_comment
      post :add_ride
    end
  end
  get 'trips/tags/:tag', to: 'trips#index', as: 'tag'

  resources :rides, only: [:create, :update, :destroy] do
    member do
      delete :delete_photo
    end
  end

  match 'home' => 'welcome#home'
  match 'about' => 'welcome#about'


  # making static crisp html templates available to see if they are displayed correctly
  match 'crisp/:action', controller: :crisp if Rails.env == 'development'

  root to: "welcome#home"

  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
end
