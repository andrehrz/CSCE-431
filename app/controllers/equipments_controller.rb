class EquipmentsController < ApplicationController
  require 'date'

  # Account Authorization
  def auth_admin
    redirect_to(root_path) unless current_account.is_admin
  end

  # Run auth befor all actions
  before_action :authenticate_account!
  before_action :auth_admin, only: %i[index show new create edit update delete destroy]

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
    invalid_item = false
    @equipment = Equipment.find(params[:id])

    # Cant check out if its already checked out.
    invalid_item = true if !@equipment.reservation_id.nil? && (@equipment.available == false)

    if invalid_item
      redirect_to(equipments_equip_list_path)
      flash[:alert] = 'Notice: That item is already checked out!'
    else
      # Find current account and the wanted item
      @acc_id = current_account.id
      @current_time = DateTime.now
      @return_time = @current_time + 7

      # Make a new reservation, set owner as the current user
      @reservation = Reservation.new(account_id: @acc_id, checkout_date: @current_time, checkin_date: @return_time)
      @reservation.save

      # Set equipment FK to the just made reservation
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
  end

  # Make Secure For Error Catching
  def check_in
    # Check if the item is checked out and belongs to the signed in user.
    @equipment = Equipment.find(params[:id])
    can_check_in = false

    # If checked out
    # If belongs to current user
    if !@equipment.reservation_id.nil? && (@equipment.available == false)
      res_obj = Reservation.find(@equipment.reservation_id)
      can_check_in = true if (res_obj.account_id == current_account.id) && (res_obj.saved_item == @equipment.name)
    end

    if can_check_in

      # Check if item is overdue and send email and increase violation count
      if DateTime.now > @equipment.reservation.checkin_date
        ReservationMailer.overdue_reservation(@equipment, current_account).deliver_now
        @new_violation_count = @equipment.reservation.account.violation_counter + 1
        @acc = Account.where(id: current_account.id)
        @acc.update(violation_counter: @new_violation_count)
      end

      # Break the link to its current reservation
      @equipment.reservation_id = nil
      @equipment.save
      @equipment.update(available: true)

      redirect_to(show_for_members_equipment_path(@equipment))

      # Sends the user an email confirming the check in
      ReservationMailer.checkin_reservation(@equipment, current_account).deliver_now

    else
      redirect_to(equipments_equip_list_path)
      flash[:alert] = 'Notice: That item is not checked out or does not belong to you!'
    end
  end

  def show_for_members
    @equipment = Equipment.find(params[:id])
    render('equipments/member_show')
  end

  def equipment_params
    params.require(:equipment).permit(:name, :description, :available)
  end
end
