Rails.application.routes.draw do
  devise_for :users
  
  namespace :api do
    # localhost:3000/api/v1/auth に認証API
    mount_devise_token_auth_for 'User', at: '/v1/auth'

    # mount API::Root => '/'

    namespace 'v1' do
      resources :lotteries
      resources :categories
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
