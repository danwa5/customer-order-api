Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :orders, only: [:index, :create]

      resources :product_sales, only: [:index]
    end
  end
end
