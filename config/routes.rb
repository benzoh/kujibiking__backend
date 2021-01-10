Rails.application.routes.draw do
  namespace :api do
    namespace 'v1' do
      resources :users
      resources :lotteries
      resources :categories
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        sessions: 'api/v1/overrides/sessions'
      }
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
