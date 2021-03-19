Rails.application.routes.draw do
  #get 'equipments/index'
  #get 'equipments/show'
  #get 'equipments/new'
  #get 'equipments/edit'
  #get 'equipments/delete'
  #get 'equipments/equip_list'
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

  root to: "home#index"
  get 'home/index'
  
  devise_for :accounts
  
  # EQUIPMENT ROUTES (Non ID routes cannot go into rescource)
  get 'equipments/index'
  get 'equipments/equip_list'
  get 'equipments/member_show'
  resources :equipments do
    member do
      get :check_out
      get :check_in
      get :show_for_members
      get :delete
    end
  end
 
  # RESERVATION ROUTES
  resources :reservations do
    member do
      get :delete
    end
  end

  # USER ROUTES 
  #get 'users/edit', to: 
  resources :users do
    member do
      get :delete
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
