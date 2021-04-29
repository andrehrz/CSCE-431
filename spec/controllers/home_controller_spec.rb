require 'rails_helper'

# Creates dummy user to use for login specs
def login_as_dummy_user
    login_as(FactoryBot.create(:account, first_name: 'Bill', last_name: 'Nye', email: 'thedjsofaggieland@gmail.com', phone_number: '1112223333', secondary_contact: 'no@gmail.com', password: 'password', is_admin: false))
end

RSpec.describe "Makes DJ account admin", type: :feature do
    scenario "the account is the DJ account" do
        user = Account.create(first_name: 'Bill', last_name: 'Nye', email: 'thedjsofaggieland@gmail.com', phone_number: '1112223333', secondary_contact: 'no@gmail.com', password: "password", password_confirmation: "password", is_admin: false)
        sign_in user
        visit root_path
        expect(page).to have_content('Home')
        visit edit_account_registration_path
        expect(page).to have_content('Admin Actions')
    end
end