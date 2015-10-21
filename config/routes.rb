Rails.application.routes.draw do

  get 'spaces_directory/index'

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout", sign_up: "register"},
                   controllers: {omniauth_callbacks: "omniauth_callbacks", sessions: 'sessions'}

  namespace :super_admin do
    get 'home' => 'home#index'
    resources :users
    resources :accounts
  end
  
  resources :reports
  resources :document, :only => [:index] do
    get :download
  end
  
  resources :home, :only => [:index, :crate_adopter] do
    post :create_adopter, :on => :collection
    get :adoptar, :on => :collection
  end

  namespace :admin do
    get 'home' => 'home#index'
    #resources :dashboard, :only => [:index]
    resources :documents
    resources :providers
    resources :provider_categories
    resources :reports, :only => [:index, :show] do
      get :cambio_estado
    end
    get 'listings/geocode' => "listings#geocode"
    resources :listings do
      resources :images do
        member do
          put :approve
        end
      end
      resources :videos
      post :reset_votes
      resources :money
    end
    resources :questions
    put 'questions/:id/approve' => 'questions#approve'
    put 'responses/:id/approve' => 'responses#approve'

    resources :adoption_requests, :only => [:index] do
      member do
        put :approve
        put :reject
      end
    end
    

    resources :adopters
    resources :events
    resources :users
    root :to => "dashboard#index"
  end

  # resources :preguntas, :controller => "questions"
  resources :questions do
    member do
      put :close
    end
  end
  get '/documentos' => "document#index"
  get '/calendario' => "event#index"
  get '/directorio' => "directory#index"
  get '/proveedores' => "provider#index"
  get '/reportes' => "reports#index"
  get '/privacidad' => "static#index"
  get '/adoptar' => "home#adoptar"
  get '/mis/preguntas' => "questions#preguntas"
  get '/mis/espacios' => "listings#espacios"

  resources :listings, path: 'espacios' do
    member { post :vote }
    get :images
    get :new_image
    post :save_image
    get :events
    get :new_event
    post :save_event
    get :videos
    get :new_video
    post :save_video
    get :dinero
    get :new_dinero
    post :save_dinero
  end
  resources :responses, :only => [:new, :create]
  get '/:listing_name' => "listings#show"
  get '/proveedores/:slug' => "provider#category"
  root :to => 'home#index'
end
