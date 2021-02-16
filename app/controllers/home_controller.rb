class HomeController < ApplicationController
  def index
    if account_signed_in?
      render('home/index')
    else
      redirect_to(new_account_session_path)
    end
  end
end
