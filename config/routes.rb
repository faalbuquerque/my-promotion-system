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
    post 'inactivate', on: :member
  end

  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :coupons, only: [:show]
    end
  end
end
