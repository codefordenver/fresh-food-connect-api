Rails.application.routes.draw do
	match "*options", 
    controller: "application/api/v1", 
    action: "options", 
    constraints: { method: "OPTIONS" }, 
    via: :options
    
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :sessions, only: :create
      resources :users
      resources :locations
      resources :donations
      resources :donation_preferences
    end
  end
end
