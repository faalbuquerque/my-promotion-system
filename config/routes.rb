Rails.application.routes.draw do

  root 'home#index'
  devise_for :admins
  resources :categories

  resources :promotions do
    post 'creates_coupons', on: :member
  end

  resources :coupons, only: [] do
    post 'inactivate', on: :member
  end
end
