class EquipmentsController < ApplicationController
    
  require 'date'

  # Account Authorization
  def auth_admin
    if !current_account.is_admin
      redirect_to(root_path)
    end
  end

  # Run auth befor all actions
  before_action :authenticate_account!
  before_action :auth_admin, only: [:index, :show, :new, :create, :edit, :update, :delete, :destroy]

  ##################################################################################################

  # Only Accessible By Admin
  def index
    @equipments = Equipment.order('id ASC')
  end

  # Only Accessible By Admin
  def show
    @equipment = Equipment.find(params[:id])
  end

  # Only Accessible By Admin
  def new
    @equipment = Equipment.new
  end

  # Only Accessible By Admin
  def create
    @equipment = Equipment.new(equipment_params)
    if @equipment.save
      redirect_to(equipments_path)
    else
      render('new')
    end
  end

  # Only Accessible By Admin
  def edit
    @equipment = Equipment.find(params[:id])
  end

  # Only Accessible By Admin
  def update
    @equipment = Equipment.find(params[:id])
    if @equipment.update(equipment_params)
      redirect_to(equipment_path(@equipment))
    else
      render('edit')
    end
  end

  # Only Accessible By Admin
  def delete
    @equipment = Equipment.find(params[:id])
  end

  # Only Accessible By Admin
  def destroy
    @equipment = Equipment.find(params[:id])
    @equipment.destroy
    redirect_to(equipments_path)
  end

  def equip_list
    @equipments = Equipment.order('id ASC')
    render('equipments/equip_list')
  end

  # Make Secure For Error Catching
  def check_out
    # Find current account and the wanted item
    @acc_id = current_account.id
    @current_time = DateTime.now
    @return_time = @current_time + 7

    # Make a new reservation, set owner as the current user
    @reservation = Reservation.new(account_id: @acc_id, checkout_date: @current_time, checkin_date: @return_time)
    @reservation.save

    # Set equipment FK to the just made reservation
    @equipment = Equipment.find(params[:id])
    @equipment.reservation = @reservation

    # Protect
    @equipment.save

    # Update Item Info For Equipment Log
    @reservation.update(saved_item: @equipment.name)
    @reservation.update(renter_name: current_account.first_name + ' ' + current_account.last_name)

    # Update its availability
    @equipment.update(available: false)
    redirect_to(show_for_members_equipment_path(@equipment))

    # Sends the user an email confirming the check out
    ReservationMailer.checkout_reservation(@equipment, current_account).deliver_now
  end

  # Make Secure For Error Catching
  def check_in
    # Break the link to its current reservation
    @equipment = Equipment.find(params[:id])
    @equipment.reservation_id = nil
    @equipment.save
    @equipment.update(available: true)
    redirect_to(show_for_members_equipment_path(@equipment))

    # Sends the user an email confirming the check in
    ReservationMailer.checkin_reservation(@equipment, current_account).deliver_now
  end

  def show_for_members
    @equipment = Equipment.find(params[:id])
    render('equipments/member_show')
  end

  def equipment_params
    params.require(:equipment).permit(:name, :description, :available)
  end
end
