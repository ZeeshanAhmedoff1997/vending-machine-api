Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'user/auth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :products

      resource :user, only: [] do
        resources :products, only: [] do 
          collection do
            get :index, action: :user_products
          end
        end
      end
    end
  end
end
