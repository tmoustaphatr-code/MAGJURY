Rails.application.routes.draw do

  root 'home#accueil'

  resources :posts, param: :slug do
    resources :comments, only: [:create], shallow: true do
      member do
        post :flag
      end
    end
  end
  resources :tags
  resources :categories


  # config/routes.rb
get 'magazine', to: 'magazine#index', as: :magazine

  get 'dashboard/index'
    devise_for :users, 
      skip: [:sessions, :registrations], # Important : skip les routes qu'on va redéfinir
      controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        passwords: 'users/passwords',
        unlocks: 'users/unlocks'
      }

    # Redéfinition personnalisée des routes principales
  devise_scope :user do
    # sessions
    get    'connexion'   => 'users/sessions#new',     as: :login
    post   'connexion'   => 'users/sessions#create',  as: :user_session
    delete 'deconnexion' => 'users/sessions#destroy', as: :logout

    # registrations (inscription + edition)
    get   'inscription' => 'users/registrations#new',    as: :signup
    post  'inscription' => 'users/registrations#create', as: :user_registration

    get   'profil/edit' => 'users/registrations#edit',   as: :edit_user_registration
    put   'profil'      => 'users/registrations#update'
    patch 'profil'      => 'users/registrations#update'
  end
  
 get 'mon_profil', to: 'users#show', as: :user_profile
  namespace :admin do
    resources :users do
      member do
        patch :block
        patch :unblock
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
