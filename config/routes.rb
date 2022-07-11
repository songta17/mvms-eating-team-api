Rails.application.routes.draw do
  resources :addresses
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  namespace :api do
    namespace :v1 do
      resources :restaurants
      resources :addresses 
    end
  end
end
