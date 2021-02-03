Rails.application.routes.draw do

  root 'home#index'
  resources :categories

  resources :promotions do
    post 'creates_coupons', on: :member
  end

end
