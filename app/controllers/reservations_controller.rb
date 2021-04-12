class ReservationsController < ApplicationController
  # Account Authorization
  def auth_admin
    redirect_to(root_path) unless current_account.is_admin
  end

  before_action :authenticate_account!
  before_action :auth_admin, only: [:reservation_log]
  require 'date'

  ####################################

  def index
    # Create a new reservation for the date
    @reservation = Reservation.new

    # Display Reservations That Are Mine
    @reservations = Reservation.order('id DESC')
  end

  # Should stay empty
  def show
    # @reservation = Reservation.find(params[:id])
  end

  # Should stay empty
  def new
    # @reservation = Reservation.new
  end

  # Should stay empty
  def create
    # @reservation = Reservation.new(reservation_params)
    # if @reservation.save
    #   redirect_to(equipments_path)
    # else
    #   render('new')
    # end
  end

  # Should stay empty
  def edit
    # @reservation = Reservation.find(params[:id])
  end

  # Should stay empty
  def update
    # @reservation = Reservation.find(params[:id])
    # if @reservation.update(reservation_params)
    #   redirect_to(reservation_path(@reservation))
    # else
    #   render('edit')
    # end
  end

  # Should stay empty
  def delete
    # @reservation = Reservation.find(params[:id])
  end

  # Should stay empty
  def destroy
    # @reservation = Reservation.find(params[:id])
    # @reservation.destroy
    # redirect_to(reservations_path) # , notice:"#{@book.Title} Was Deleted !")
  end

  def equip_reserve
    # Use passed in date, check if there is no reservation for the same item on that day
    event_string = params[:reservation][:event_description]
    reserve_t = (params[:reservation][:checkout_date]).to_datetime
    # reserve_t = reserve_t.new_offset("-0600")

    return_t = reserve_t + 1.day
    @future_date = Reservation.new(event_description: event_string, checkout_date: reserve_t, checkin_date: return_t)

    # Display Equipment To Be Reserved
    @equipments = Equipment.order('id ASC')

    # Display Reservations That Are Mine
    @reservations = Reservation.order('id DESC')

    render('reservations/equip_reserve')
  end

  # Only admin access
  def reservation_log
    @reservations = Reservation.order('checkout_date DESC')
    render('reservations/equip_log')
  end

  # def future_reservations
  #   @reservations = Reservation.order('checkout_date ASC')
  # end

  def reserve_item
    # Use passed in date, check if there is no reservation for the same item on that day
    @event_string = params[:event]
    @future_date = params[:cd].to_datetime
    @return_date = @future_date + 1.day

    # ID of desired item
    @equipment = Equipment.find(params[:id])

    # Check if item is avail for the passed in day
    invalid_reservation = false
    @reservation_list = Reservation.order('id DESC') # Optimize for search speedup. WHERE future_equip_id != null.
    @reservation_list.each do |curr_res|
      # Check if theres a reservation with the same item on the same day or in reservation range.
      invalid_reservation = true if (curr_res.checkout_date <= @future_date) && (@future_date <= curr_res.checkin_date) && (curr_res.future_equip_id == @equipment.id)
    end

    # If invalid_reservation is still false, we can make a future reservation.
    if invalid_reservation == false
      @acc_id = current_account.id # Find current account and the wanted item
      @reservation = Reservation.new(account_id: @acc_id, future_equip_id: @equipment.id, checkout_date: @future_date,
                                     checkin_date: @return_date, event_description: @event_string)
      @reservation.future_equip_id = @equipment.id

      # Update Item Info For Equipment Log
      @reservation.saved_item = @equipment.name
      @reservation.renter_name = current_account.first_name + ' ' + current_account.last_name

      if @reservation.save
        # Sends the user a confirmation email for the reservation
        ReservationMailer.item_reservation(@equipment, @reservation, current_account).deliver_now
        flash[:alert] = 'Notice: Reservation Complete!'
      else
        flash[:alert] = 'Notice: Error making reservation!'
      end
    else
      flash[:alert] = 'Notice: Equipment item is already reserved on your day!'
    end
    redirect_to(reservations_path)
  end

  def reservation_list
    # Get Reservation List
    @reservations = Reservation.order('id ASC')
  end

  def cancel_item
    # Get reservation by its passed in id.
    @reservation = Reservation.find(params[:id])

    # Set the reservation future equip id to nil.
    @reservation.future_equip_id = nil

    # @reservation.account_id = nil

    # Protect
    @reservation.save

    # Delete the reservation (possibly).
    # Re-render
    redirect_to(reservations_path) # Possibly change to do a show action
    flash[:alert] = 'Notice: Reservation Cancelled!'
  end

  def admin_cancel_item
    # Get reservation by its passed in id.
    @reservation = Reservation.find(params[:id])

    # Set the reservation future equip id to nil.
    @reservation.future_equip_id = nil

    # @reservation.account_id = nil

    # Protect
    @reservation.save

    # Delete the reservation (possibly).
    # Re-render
    redirect_to(reservations_reservation_list_path) # Possibly change to do a show action
    flash[:alert] = 'Notice: Reservation Cancelled!'
  end
end
