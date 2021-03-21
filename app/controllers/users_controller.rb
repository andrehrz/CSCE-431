class UsersController < ApplicationController
  def index
    @users = Account.order('id ASC');
  end

  def show
    @users = Account.find(params[:id])
  end

 #NOT NEEDED (i think)
  def new
    @users = Account.new;
  end

  #NOT NEEDED (i think)
  def create
    @users = Account.new(user_params)

    if @users.save
      redirect_to(users_path) #, notice:"#{@book.Title} Was Added !")
    else
      render('new')
    end
  end

  def edit
    @users = Account.find(params[:id])
  end

  def update
    @users = Account.find(params[:id])
    if @users.update(user_params)
      redirect_to(users_path(@users)) #, notice:"#{@book.Title} Was Updated !")
    else
      render('edit')
    end
  end

  def delete
    @users = Account.find(params[:id])
  end

  def destroy
    @users = Account.find(params[:id])
    @users.destroy
    redirect_to(users_path) #, notice:"#{@book.Title} Was Deleted !")
  end

  def user_params
    params.require(:account).permit(:first_name, :last_name, :email, :phone_number, :secondary_contact)
  end
end
