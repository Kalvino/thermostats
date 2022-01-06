Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: 'thermostats#index'

  resources :thermostats do
    resources :readings, shallow: true
  end
  get 'house_readings', to: 'readings#house_readings', as: :house_readings
  get 'reading', to: 'readings#show'
end
# <%= link_to 'Show Ad', [:edit, @ad] %>
# <%= link_to 'edit', [:edit, @ad,@comment] %>

