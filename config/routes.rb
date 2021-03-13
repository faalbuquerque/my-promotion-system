Rails.application.routes.draw do

  root 'home#index'
  devise_for :admins
  resources :categories

  resources :promotions do
    member do 
      post 'creates_coupons'
      post 'approve'
    end
  end

  get 'search', to: 'promotions#search'

  resources :coupons, only: [] do
    member do
      post 'inactivate'
      post 'activate'
    end
  end
end
