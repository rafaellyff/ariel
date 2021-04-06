Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        registrations: 'api/v1/users/registrations',
        sessions: 'api/v1/users/sessions'
      }
      
      resources :molecules
      resources :posts
      resources :hormones
      resources :boxes
      resources :events
      resources :doses do
        get 'next_dose', on: :collection
        get 'confirm_dose', on: :collection
      end
      
      get 'calendar/next_events', to: 'calendar#next_events'
      get 'calendar/filter_events', to: 'calendar#filter_events'
    end
  end

end
