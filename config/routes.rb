Rails.application.routes.draw do

  resources :members, as: :podio_members
  resources :teams, as: :podio_battle_teams do
    resource :report
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "welcome#show"
end
