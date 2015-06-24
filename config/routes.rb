Hitchlog::Application.routes.draw do
  devise_for :users, path_names: { :sign_in => 'login' }, path: 'hitchhikers'

  filter :locale

  match 'auth/:provider/callback', to: 'omniauth#create', via: :post
  match 'auth/failure', to: redirect('/'), via: :get
  match 'signout', to: 'sessions#destroy', as: 'signout', via: :get

  # omniauth:

  resources :future_trips, path: 'hitchhiking_buddies', except: [:show]

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

  match 'home' => 'welcome#home', via: :get
  match 'about' => 'welcome#about', via: :get


  # making static crisp html templates available to see if they are displayed correctly
  match 'crisp/:action', controller: :crisp, via: :get if Rails.env == 'development'

  root to: "welcome#home"

  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
end
