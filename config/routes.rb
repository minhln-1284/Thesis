Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#index"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/mens", to: "products#mens"
    get "/womans", to: "products#womans"
    get "sort", to: "categories#category_sort"
    devise_for :users
    resources :users, except: :destroy
    resources :account_activations, only: %i(edit create)
    resources :password_resets, except: %i(destroy index show)

    namespace :admin do
      get "search", to: "products#index"
      resources :static_pages
      resources :categories
      resources :orders
      resources :products
      resources :users
      resources :banners
      root "static_pages#index"
    end
    resources :ratings
    resources :order_details
    resources :categories do
      member do
        get :filter
      end
    end
    resources :products do
      collection do
        get :result
      end
    end
    resources :carts
    resources :orders do
      member do
        get :change
      end
    end
  end
end
