class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.order('id ASC');
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new;
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to(reservations_path) #, notice:"#{@book.Title} Was Added !")
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
      redirect_to(reservation_path(@reservation)) #, notice:"#{@book.Title} Was Updated !")
    else
      render('edit')
    end
  end

  def delete
  end

  def reservation_params
    params.require(:reservation).permit(:event_description, :checkout_date, :checkin_date)
  end
end
