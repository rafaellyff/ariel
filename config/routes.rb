Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        registrations: 'api/v1/users/registrations',
        confirmations: 'api/v1/users/confirmations',
        sessions: 'api/v1/users/sessions'
      }
      
      resources :molecules
      resources :posts
      resources :hormones
      resources :boxes
    end
  end

end
