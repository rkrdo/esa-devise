Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }

  namespace :api, defaults: { format: 'json' } do
    resources :users, only: [:index, :show]
    resources :registrations, only: :create, path: 'sign_up'
  end
end
