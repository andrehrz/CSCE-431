class UsersController < ApplicationController
    before_action :authenticate_account!
  
    # Find all books for template
    def index
      @users = Account.order('id ASC')
    end
  
    # Find book for template
    def show
      @user = Account.find(params[:id])
    end
  
    # Should stay Empty
    def new; end
  
    # Should stay empty
    def create; end
  
    # Edit an existing user as admin
    def edit
      @user = Account.find(params[:id])
    end
  
    # Update an existing user as admin
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
  
    # Delete an account as admin
    def delete
      @user = Account.find(params[:id])
    end
  
    # Destroy an account as admin
    def destroy
      @user = Account.find(params[:id])
      @user.destroy
      redirect_to(users_path)
      flash[:alert] = 'Notice: Account deleted successfully.'
    end
  
    private
  
    def user_params
      params.require(:account).permit(:email, :first_name, :last_name, :phone_number, :secondary_contact, :is_admin)
    end
  end