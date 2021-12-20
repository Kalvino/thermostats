Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: 'readings#index'

  resources :readings, only: %i[index show create]

  get 'house_readings', to: 'readings#house_readings', as: :house_readings
  get 'reading', to: 'readings#show' 
  get 'stats', to: 'readings#stats'
end
