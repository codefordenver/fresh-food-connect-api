Rails.application.routes.draw do
  match "*options",
        controller:  "application/api/v1",
        action:      "options",
        constraints: { method: "OPTIONS" },
        via:         :options

  # mounting this outside of the api/v1 namespace resolves an annoying bug
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do

      resources :sessions, only: :create

      resources :users do
        resources :locations do
          resources :donations
        end
      end

      get 'donations', to: 'donations#list'
    end
  end
end
