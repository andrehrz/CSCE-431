class EquipmentsController < ApplicationController

  def index
    @equipments = Equipment.order('id ASC');
  end

  def show
    @equipment = Equipment.find(params[:id])
  end

  def new
    @equipment = Equipment.new;
  end

  def create
    @equipment = Equipment.new(equipment_params)
    
    if @equipment.save
      redirect_to(equipments_path) #, notice:"#{@book.Title} Was Added !")
    else
      render('new')
    end
  end

  def edit
    @equipment = Equipment.find(params[:id])

  end

  def update
    @equipment = Equipment.find(params[:id])
    if @equipment.update(equipment_params)
      redirect_to(equipment_path(@equipment)) #, notice:"#{@book.Title} Was Updated !")
    else
      render('edit')
    end
  end

  def delete
    @equipment = Equipment.find(params[:id])
  end

  def destroy
    @equipment = Equipment.find(params[:id])
    @equipment.destroy
    redirect_to(equipments_path) #, notice:"#{@book.Title} Was Deleted !")
  end

  def equip_list
    @equipments = Equipment.order('id ASC');
    render('equipments/equip_list')
  end

  def check_in
  end

  def check_out
  end

  def equipment_params
    params.require(:equipment).permit(:name, :description, :available)
  end

end
