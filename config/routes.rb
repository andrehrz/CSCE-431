Rails.application.routes.draw do
  # get 'equipments/index'
  # get 'equipments/show'
  # get 'equipments/new'
  # get 'equipments/edit'
  # get 'equipments/delete'
  # get 'reservations/index'
  # get 'reservations/show'
  # get 'reservations/new'
  # get 'reservations/edit'
  # get 'reservations/delete'
  # get 'users/index'
  # get 'users/show'
  # get 'users/new'
  # get 'users/edit'
  # get 'users/delete'

  #root 'equipments#index'
  
  resources :equipments do
    member do
      get :delete
    end
  end

  resources :users do
    member do
      get :delete
    end
  end

  resources :reservations do
    member do
      get :delete
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
