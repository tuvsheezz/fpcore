Rails.application.routes.draw do
  get 'tusgaibaraa/index'
  resources :prodchanges
  #get "/404", :to => "errors#not_found"

  #get "/422", :to => "errors#unacceptable"

  #get "/500", :to => "errors#internal_error"

  get 'retsale/index'

  get 'debt/index'

  get 'balance/index'

  get 'outofstock/index'

  get 'search/index'

  resources :machigainaoshis, except: [:edit, :show, :destroy] do
    patch :check, on: :member
  end
  resources :munguunuus, except: :destroy
  resources :nymdavaas, except: [:edit, :update] do
    patch :sent, on: :member
    patch :rec, on: :member
    patch :gave, on: :member
  end
  resources :stocks, except: :destroy do
    get :report, on: :member
  end
  resources :orders, except: :show do
    patch :check, on: :member
  end
  resources :debts, except: [:new, :destroy] do
    get :paid, on: :collection
  end
  resources :transfers do
    patch :check, on: :member
  end
  resources :sales, except: :destroy
  resources :dollar_logs, only: [:index, :new, :create]
  resources :yuan_logs, only: [:index, :new, :create]
  resources :item_logs, only: [:index, :new, :create]
  resources :user_logs, only: [:index, :new, :create]
  resources :subcategory_logs, only: [:index, :new, :create]
  resources :category_logs, only: [:index, :new, :create]
  resources :branch_logs, only: [:index, :new, :create]
  resources :products, except: :destroy do
    get :check, on: :collection
    get :select, on: :collection
    get :report, on: :collection
    get :print, on: :collection
    get :bybranchid, on: :collection
  end
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  resources :branches, except: :destroy
  resources :items, except: :destroy do
    get :select, on: :collection
    get :select2, on: :collection
    get :report, on: :collection
  end
  resources :ratedollars, only: [:index, :new, :create]
  resources :rateyuans, only: [:index, :new, :create]
  resources :subcategories, except: :destroy
  resources :categories, except: :destroy
  resources :users, except: :destroy
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
