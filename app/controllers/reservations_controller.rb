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

  def edit
  end

  def delete
  end
end
