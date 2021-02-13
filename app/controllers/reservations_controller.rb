class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.order('id ASC');
  end

  def show
  end

  def new
  end

  def edit
  end

  def delete
  end
end
