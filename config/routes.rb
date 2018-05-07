Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :actors, only: :index do
        get 'search/:birth_month/:birth_day', on: :collection, to: 'actors#search'
      end
    end
  end
end
