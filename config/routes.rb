Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :flights, only: [] do
        collection do
          get :find
        end
      end
    end
  end
end
