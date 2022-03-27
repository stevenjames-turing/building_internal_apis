Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do 
    namespace :v1 do 
      resources :author do 
        resources :books, only: [:index, :show, :create, :update, :destroy]
      end
    end
    namespace :v2 do 
      resources :author do 
        resources :books, only: [:index]
      end
    end
  end
  
end
