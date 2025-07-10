Rails.application.routes.draw do

  devise_for :users, path_names: { sign_in: "login", sign_out: "logout", sign_up: "signup"},
                     controllers: { omniauth_callbacks: "omniauth_callbacks",
                                    registrations: 'registrations',
                                    sessions: 'sessions'
                                  } do
    get '/users/auth/:provider/failure', to: 'omniauth_callbacks#failure'
  end
  
  root 'pages#home' 
  
  get 'pages/home', to: 'pages#home'

  get '/preload' => 'reservations#preload'
  get '/preview' => 'reservations#preview'
  get '/your_trips' => 'reservations#your_trips'
  get '/yourlisting_reservations' => 'reservations#yourlisting_reservations'
  get '/search' => 'pages#search'
  get '/attribution' => 'pages#attribution'

  resources :rooms do 
    member do
      get :map_image
    end
    resources :reservations, only: [:create]
  end

  resources :conversations, only: [:index, :create] do  
    resources :messages, only: [:index, :create]
  end

  resources :rooms do 
    resources :reviews, only: [:create, :destroy]
  end

  # Place users resource at the end
  resources :users, only: [:show], constraints: { id: /\d+/ } 
  
  # Serve star rating images
  get '/images/star-on.png', to: proc { [200, {}, [File.read(Rails.root.join('app', 'assets', 'images', 'star-on.png'))]] }
  get '/images/star-off.png', to: proc { [200, {}, [File.read(Rails.root.join('app', 'assets', 'images', 'star-off.png'))]] }
  get '/images/star-half.png', to: proc { [200, {}, [File.read(Rails.root.join('app', 'assets', 'images', 'star-half.png'))]] }
end
