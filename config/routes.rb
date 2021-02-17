Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      get 'categories/', to: 'categories#index'
    end
  end
  namespace :api do
    namespace :v1 do
      post 'orders/', to: 'orders#create'
      get 'orders/:id', to: 'orders#show'
    end
  end
  namespace :api do
    namespace :v1 do
      get 'customers', to: 'customers#index'
      post 'customers', to: 'customers#create'
      put 'customers/:id', to: 'customers#update'
      get 'customers/:id', to: 'customers#show'
      delete 'customers/:id', to: 'customers#destroy'
    end
  end
  namespace :api do
    namespace :v1 do
      get 'articles/:id', to: 'articles#show'
      put 'articles/:id', to: 'articles#edit'
      get 'articles/find/:id',to: 'articles#find_article'
      delete 'articles/:id', to: 'articles#destroy'
      post 'articles/', to: 'articles#create'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
