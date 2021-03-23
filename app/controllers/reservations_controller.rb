class ReservationsController < ApplicationController
  before_action :authenticate_account!
  require 'date'

  def index
    # Create a new reservation for the date
    @reservation = Reservation.new
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to(equipments_path) # , notice:"#{@book.Title} Was Added !")
    else
      render('new')
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      redirect_to(reservation_path(@reservation)) # , notice:"#{@book.Title} Was Updated !")
    else
      render('edit')
    end
  end

  def delete
    @reservation = Reservation.find(params[:id])
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to(reservations_path) # , notice:"#{@book.Title} Was Deleted !")
  end

  def equip_reserve
    # Use passed in date, check if there is no reservation for the same item on that day
    event_string = params[:reservation][:event_description]
    reserve_t = (params[:reservation][:checkout_date]).to_datetime
    #reserve_t = reserve_t.new_offset("-0600")

    return_t = reserve_t + 1.days
    @future_date = Reservation.new(event_description: event_string, checkout_date: reserve_t, checkin_date: return_t)

    # Display Equipment To Be Reserved
    @equipments = Equipment.order('id ASC')

    # Display Reservations That Are Mine
    @reservations = Reservation.order('id DESC')

    render('reservations/equip_reserve')
  end

  def equip_log
    @reservations = Reservation.order('checkout_date DESC');
    render('reservations/equip_log')
  end

  def future_reservations
    @reservations = Reservation.order('checkout_date ASC');
  end

  def reserve_item
    params.each do |key,value|
       Rails.logger.warn "Param #{key}: #{value}"
    end

    # Use passed in date, check if there is no reservation for the same item on that day
    @event_string = params[:event]
    @future_date = (params[:cd]).to_datetime
    @return_date = @future_date + 1.days

    puts @future_date
    puts @return_date
    puts @event_string

    #@future_date = DateTime.now + 1 # Either as post params or Reservation hashes
    #@return_date = @future_date + 1 # Either as post params or  Reservation hashes

    # ID of desired item
    @equipment = Equipment.find(params[:id])

    # Check if item is avail for the passed in day
    invalid_reservation = false
    @reservation_list = Reservation.order('id DESC') # Optimize for search speedup. WHERE future_equip_id != null.
    @reservation_list.each do |curr_res|
      if (curr_res.checkout_date <= @future_date) && (@future_date <= curr_res.checkin_date) && (curr_res.future_equip_id == @equipment.id) # Possible invalid case. Need to check future_equip_id.
        invalid_reservation = true
      end
    end

    # If invalid_reservation is still false, we can make a future reservation.
    if invalid_reservation == false
      @acc_id = current_account.id # Find current account and the wanted item
      @reservation = Reservation.new(account_id: @acc_id, future_equip_id: @equipment.id, checkout_date: @future_date,
                                      checkin_date: @return_date, event_description: @event_string)
      @reservation.future_equip_id = @equipment.id

      if @reservation.save # Protect
        redirect_to(reservations_future_reservations_path) # Possibly change to do a show action
      else 
        redirect_to(root_path)
      end
    else
      redirect_to(reservations_path)
      flash[:alert] = 'Notice: Equipment item is already reserved on your day!'
    end
  end

  def cancel_item
    if !account_signed_in?
      redirect_to(new_account_session_path)
    else
      # Undo a future reservation.
      # Get reservation by its passed in id.
      @reservation = Reservation.find(params[:id])
      # Set the reservation future equip id to nil.
      @reservation.future_equip_id = nil
      # @reservation.account_id = nil
      # Protect
      @reservation.save
      # Delete the reservation (possibly).
      # Re-render
      redirect_to(reservations_future_reservations_path) # Possibly change to do a show action
    end
  end

  def reservation_params
    params.require(:reservation).permit(:event_description, :checkout_date, :checkin_date)
  end
end



# def check_invalid? (equipment, reslist)
#   avail = true
#   reslist.each do |resv|
#       if (resv.checkout_date <= @future_date) && (@future_date <= resv.checkin_date) && (resv.future_equip_id == equipment.id)
#         avail = false
#       end
#   end
#   avail == true
# end