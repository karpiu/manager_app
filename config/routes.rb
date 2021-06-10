Rails.application.routes.draw do
  resources :payment_requests, only: [:index] do
    member do
      post :accept
      post :reject
    end
  end

  root to: 'payment_requests#index'
end
