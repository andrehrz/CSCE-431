require 'rails_helper'

# 1. Generate some test data
# 2. Log into the application
# 3. Visit the page I’m interested in
# 4. Perform whatever clicks and typing need to happen in order to exercise the feature I’m testing
# 5. Perform an assertion

# Creates dummy user to use for login specs
def login_as_dummy_user
    login_as(FactoryBot.create(:account, first_name: 'Bill', last_name: 'Nye', email: 'thescienceguy@test.com', phone_number: '1112223333', secondary_contact: 'no@gmail.com', password: 'password'))
end

# Sign up integration test
RSpec.describe "Account Sign Up", type: :feature do
    scenario "visiting site to sign up" do
        visit new_account_registration_path
        fill_in 'First name', with: 'Bobby'
        fill_in 'Last name', with: 'Johnson'
        fill_in 'Email', with: 'chrisplummer68@gmail.com'
        fill_in 'Phone number', with: '5128108965'
        fill_in 'Secondary contact', with: 'cwp684@gmail.com'
        fill_in 'Password', with: 'cpadmin'
        fill_in 'Password confirmation', with: 'cpadmin'
        click_button 'Sign up'
        visit root_path
        expect(page).to have_content('Welcome')
    end
end

# Log in integration test
RSpec.describe "Account Log In", type: :feature do
    scenario "visiting site to login" do
        visit new_account_session_path
        login_as_dummy_user
        visit root_path
        expect(page).to have_content('Welcome')
    end
end

# Show integration test
RSpec.describe "Account Shows Info", type: :feature do
    scenario "valid info" do
        visit new_account_session_path
        login_as_dummy_user
        visit edit_account_registration_path
        expect(page).to have_content('Edit Account')
        expect(page).to have_content('Bill')
        expect(page).to have_content('Nye')
        expect(page).to have_content('thescienceguy@test.com')
        expect(page).to have_content('1112223333')
        expect(page).to have_content('no@gmail.com')
    end
end

# Edit account integration test
RSpec.describe "Update Account Info", type: :feature do
    scenario "valid inputs" do
        visit new_account_session_path
        login_as_dummy_user
        visit edit_account_registration_path
        fill_in 'First name', with: 'Bobby'
        fill_in 'Last name', with: 'Johnson'
        fill_in 'Email', with: 'chrisplummer68@gmail.com'
        fill_in 'Phone number', with: '5128108965'
        fill_in 'Secondary contact', with: 'cwp684@gmail.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        fill_in 'Current password', with: 'password'
        click_button 'Update'
        expect(page).to have_content('Your account has been updated successfully.')
        expect(page).to have_content('Welcome')
        sleep(2)
        visit edit_account_registration_path
        expect(page).to have_content('Edit Account')
        expect(page).to have_content('Bobby')
        expect(page).to have_content('Johnson')
        expect(page).to have_content('chrisplummer68@gmail.com')
        expect(page).to have_content('5128108965')
        expect(page).to have_content('cwp684@gmail.com')
    end
end

# Delete account integration test
RSpec.describe "Delete Account", type: :feature do
    scenario "deleting account with button" do
        visit new_account_session_path
        login_as_dummy_user
        visit edit_account_registration_path
        page.accept_alert 'Are you sure?' do
            click_button 'Cancel my account'
        end
        expect(page).to have_content('Log in')
        login_as_dummy_user
        sleep(1)
        expect(page).to have_content('Log in')
        sleep(1)
    end
end