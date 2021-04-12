require 'rails_helper'

# 1. Generate some test data
# 2. Log into the application
# 3. Visit the page I’m interested in
# 4. Perform whatever clicks and typing need to happen in order to exercise the feature I’m testing
# 5. Perform an assertion

# Creates dummy user to use for login specs
def login_as_dummy_user
    login_as(FactoryBot.create(:account, first_name: 'Bill', last_name: 'Nye', email: 'thescienceguy@test.com', phone_number: '1112223333', secondary_contact: 'no@gmail.com', password: 'password', is_admin: 'true'))
end

RSpec.describe "Admin Manage Accounts Feature", type: :feature do

    scenario "ensure account list works" do
        user = Account.create(first_name: 'Super', last_name: 'Tester', email: 'test@test.com', phone_number: '1112223333', secondary_contact: 'no@gmail.com', password: "password", password_confirmation: "password", is_admin: true)
        sign_in user
        visit edit_account_registration_path
        click_on 'Manage Accounts'
        expect(page).to have_content('Admin User Management')
        expect(page).to have_content('Super')
        expect(page).to have_content('Tester')
        expect(page).to have_content('test@test.com')
        expect(page).to have_content('Show')
        expect(page).to have_content('Edit')
        expect(page).to have_content('Delete')
    end

    scenario "ensure show feature" do
        user = Account.create(first_name: 'Super', last_name: 'Tester', email: 'test@test.com', phone_number: '1112223333', secondary_contact: 'no@gmail.com', password: "password", password_confirmation: "password", is_admin: true)
        sign_in user
        visit edit_account_registration_path
        click_on 'Manage Accounts'
        click_link 'Show'
        expect(page).to have_content('Super')
        expect(page).to have_content('Tester')
        expect(page).to have_content('test@test.com')
        expect(page).to have_content('1112223333')
        expect(page).to have_content('no@gmail.com')
    end

    scenario "ensure edit feature" do
        user = Account.create(first_name: 'Super', last_name: 'Tester', email: 'test@test.com', phone_number: '1112223333', secondary_contact: 'no@gmail.com', password: "password", password_confirmation: "password", is_admin: true)
        sign_in user
        visit edit_account_registration_path
        click_on 'Manage Accounts'
        click_link 'Edit'
        expect(page).to have_content('Edit User Info')
        fill_in 'Email', with: 'admintest@test.com'
        select "Yes", from: 'account_is_admin'
        click_button 'Update User'
        expect(page).to have_content('Admin User Management')
        expect(page).to have_content('Notice: User successfully edited.')
        expect(page).to have_content('admintest@test.com')
    end

    scenario "ensure edit fails with validation" do
        user = Account.create(first_name: 'Super', last_name: 'Tester', email: 'test@test.com', phone_number: '1112223333', secondary_contact: 'no@gmail.com', password: "password", password_confirmation: "password", is_admin: true)
        sign_in user
        visit edit_account_registration_path
        click_on 'Manage Accounts'
        click_link 'Edit'
        expect(page).to have_content('Edit User Info')
        fill_in 'Email', with: ''
        select "Yes", from: 'account_is_admin'
        click_button 'Update User'
        expect(page).to have_content('Notice: Error when updating user.')
    end

    scenario "ensure delete feature" do
        user = Account.create(first_name: 'Super', last_name: 'Tester', email: 'test@test.com', phone_number: '1112223333', secondary_contact: 'no@gmail.com', password: "password", password_confirmation: "password", is_admin: true)
        sign_in user

        FactoryBot.create(:account, first_name: 'Bill', last_name: 'Nye', email: 'thescienceguy@test.com', phone_number: '1112223333', secondary_contact: 'no@gmail.com', password: 'password', is_admin: 'false')
        
        visit edit_account_registration_path
        click_on 'Manage Accounts'

        expect(page).to have_content('Bill')
        page.all(:link, text: "Delete")[1].click
        expect(page).to have_content('Delete Selected User')
        expect(page).to have_content('Bill')
        expect(page).to have_content('Nye')
        click_on "Delete User"
        expect(page).to have_content('Super')
        expect(page).to have_content('Notice: Account deleted successfully.')
        expect(page).to have_no_content('Bill')
    end
end

RSpec.describe "Admin Manage Equipment Feature", type: :feature do

end