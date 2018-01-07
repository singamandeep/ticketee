Rails.application.routes.draw do
 
  namespace :admin do
    root "application#index"
    
    resources :projects, only: [:new, :create, :destroy]     
    resources :users do
      member do
        patch :archive
      end
    end
  end

 
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

 

  root 'projects#index'

 

  resources :projects, only: [:index, :show, :edit, :update] do
  	resources :tickets
  end

  namespace :api do
    resources :projects, only: [] do
      resources :tickets
    end
  end

end
