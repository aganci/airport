Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :flights, only: [] do
        collection do
          get :find
        end
        member do
          post :book
        end
      end

      post :authenticate, to: 'authentication#authenticate'
    end
  end
end
