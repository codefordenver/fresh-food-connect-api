Rails.application.routes.draw do
	match "*options", controller: "application/api/v1", action: "options", constraints: { method: "OPTIONS" }, via: :options
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :sessions, only: :create
    end
  end
end
