Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  devise_for :users, path: '', path_names: {
                                 sign_in: 'api/login',
                                 sign_out: 'api/logout',
                                 registration: 'api/signup'
                               },
                     controllers: {
                       sessions: 'api/users/sessions',
                       registrations: 'api/users/registrations'
                     }

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      resources :activities
      resources :categories
    end
  end
end
