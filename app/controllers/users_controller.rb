class UsersController < ApplicationController
  # Account Authorization
  def auth_admin
    redirect_to(root_path) unless current_account.is_admin
  end

  # Run auth befor all actions
  before_action :authenticate_account!
  before_action :auth_admin

  ####################################

  # Only for admins
  def index
    @users = Account.order('id ASC')
  end

  # Only for admins
  def show
    @user = Account.find(params[:id])
  end

  # Should stay Empty
  def new; end

  # Should stay empty
  def create; end

  # Only for admins
  def edit
    @user = Account.find(params[:id])
  end

  # Only for admins
  def update
    @user = Account.find(params[:id])
    if @user.update(user_params)
      redirect_to(users_path)
      flash[:alert] = 'Notice: User successfully edited.'
    else
      flash[:alert] = 'Notice: Error when updating user.'
      render('edit')
    end
  end

  # Only for admins
  def delete
    @user = Account.find(params[:id])
  end

  # Only for admins
  def destroy
    @user = Account.find(params[:id])
    @user.destroy
    redirect_to(users_path)
    flash[:alert] = 'Notice: Account deleted successfully.'
  end

  private

  def user_params
    params.require(:account).permit(:email, :first_name, :last_name, :phone_number, :secondary_contact, :is_admin, :violation_counter)
  end
end
