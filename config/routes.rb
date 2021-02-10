Rails.application.routes.draw do

  root 'home#index'
  devise_for :admins
  resources :categories

  resources :promotions do
    member do 
      post 'creates_coupons'
      post 'approver'
    end
  end

  resources :coupons, only: [] do
    post 'inactivate', on: :member
  end
end
