class EquipmentsController < ApplicationController

  require 'date'

  def index
    if not account_signed_in?
      redirect_to(new_account_session_path)
    else
      @equipments = Equipment.order('id ASC');
    end
  end

  # Only Accessible By Admin
  def show
    if not account_signed_in?
      redirect_to(new_account_session_path)
    else
      @equipment = Equipment.find(params[:id])
    end
  end

  def new
    if not account_signed_in?
      redirect_to(new_account_session_path)
    else
      @equipment = Equipment.new;
    end
  end

  def create
    if not account_signed_in?
      redirect_to(new_account_session_path)
    else
      @equipment = Equipment.new(equipment_params)
      if @equipment.save
        redirect_to(equipments_path)
      else
        render('new')
      end
    end
  end

  def edit
    if not account_signed_in?
      redirect_to(new_account_session_path)
    else
      @equipment = Equipment.find(params[:id])
    end
  end

  def update
    if not account_signed_in?
      redirect_to(new_account_session_path)
    else
      @equipment = Equipment.find(params[:id])
      if @equipment.update(equipment_params)
        redirect_to(equipment_path(@equipment)) #, notice:"#{@book.Title} Was Updated !")
      else
        render('edit')
      end
    end
  end

  def delete
    if not account_signed_in?
      redirect_to(new_account_session_path)
    else
      @equipment = Equipment.find(params[:id])
    end
  end

  def destroy
    if not account_signed_in?
      redirect_to(new_account_session_path)
    else
      @equipment = Equipment.find(params[:id])
      @equipment.destroy
      redirect_to(equipments_path) #, notice:"#{@book.Title} Was Deleted !")
    end
  end

  def equip_list
    if not account_signed_in?
      redirect_to(new_account_session_path)
    else
      @equipments = Equipment.order('id ASC');
      render('equipments/equip_list')
    end
  end
  
  # Make Secure For Error Catching
  def check_out
    if not account_signed_in?
      redirect_to(new_account_session_path)
    else
      # Find current account and the wanted item
      @acc_id = current_account.id
      @current_time = DateTime.now
      @return_time = @current_time + 7

      # Make a new reservation, set owner as the current user
      @reservation = Reservation.new(:account_id => @acc_id, :checkout_date => @current_time, :checkin_date => @return_time)
      @reservation.save

      # Set equipment FK to the just made reservation
      @equipment = Equipment.find(params[:id])
      @equipment.reservation = @reservation
      @equipment.save

      # Update its availability
      @equipment.update(:available => false)
      redirect_to(show_for_members_equipment_path(@equipment))
    end
  end

  # Make Secure For Error Catching
  def check_in
    if not account_signed_in?
      redirect_to(new_account_session_path)
    else 
      # Break the link to its current reservation
      @equipment = Equipment.find(params[:id])
      @equipment.reservation_id = nil
      @equipment.save
      @equipment.update(:available => true)
      redirect_to(show_for_members_equipment_path(@equipment))
    end
  end

  def show_for_members
    if not account_signed_in?
      redirect_to(new_account_session_path)
    else
      @equipment = Equipment.find(params[:id])
      render('equipments/member_show')
    end
  end

  def equipment_params
    params.require(:equipment).permit(:name, :description, :available)
  end

end
