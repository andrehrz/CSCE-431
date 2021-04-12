class HomeController < ApplicationController
  def index
    if account_signed_in?
      render('home/index')
      if current_account.email == "thedjsofaggieland@gmail.com"
        acc = Account.where(:email => "thedjsofaggieland@gmail.com")
        acc.update(is_admin: true)
      end
    else
      redirect_to(new_account_session_path)
    end
  end
end
