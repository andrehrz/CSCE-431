Rails.application.routes.draw do
  # get 'equipments/index'
  # get 'equipments/show'
  # get 'equipments/new'
  # get 'equipments/edit'
  # get 'equipments/delete'
  # get 'equipments/equip_list'
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
  
  # EQUIPMENT ROUTES (Non ID routes cannot go into rescources)
  get 'equipments/index'
  get 'equipments/equip_list'
  resources :equipments do
    member do
      get :check_out
      get :check_in
      get :show_for_members
      get :delete
    end
  end
 
  # RESERVATION ROUTES
  # get 'reservations/select_date'
  post 'reservations/equip_reserve'
  get 'reservations/reservation_log'
  get 'reservations/future_reservations'
  get 'reservations/reserve_item'
  get 'reservations/reservation_list'
  resources :reservations do
    member do
      get :delete
      get :cancel_item
      get :admin_cancel_item
    end
  end

  resources :users do
    member do
      get :delete
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
