Rails.application.routes.draw do
  match "*options",
        controller:  "application/api/v1",
        action:      "options",
        constraints: { method: "OPTIONS" },
        via:         :options

  # mounting this outside of the api/v1 namespace resolves an annoying bug
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', controllers: {
    passwords:  'api/v1/passwords',
    registrations: 'api/v1/registrations'
  }

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do

      resources :users do
        resources :locations
        resources :donations
      end

      get 'donations', to: 'donations#list' # Admin Route
      get 'locations', to: 'locations#list' # Admin Route
      put 'locations/pickup_day' => 'locations#update_pickup_day'
      post '/emails' => 'emails#send_reminders'

    end
  end
end
