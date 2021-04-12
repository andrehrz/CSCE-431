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

def create_dummy_equipment
    Equipment.create(name:"DJ Decks", description:"Decks", available:true)
end

RSpec.describe "Reservation Feature", type: :feature do
    scenario "pick a valid date and submit" do
        visit new_account_session_path
        login_as_dummy_user
        visit reservations_path
        expect(page).to have_content('Select a Date for Reservation')
        page.find('#reservation_checkout_date').set("04-21-2021")
        page.find('#reservation_checkout_date').set("Big Party")
        click_button 'Pick Date'
        expect(page).to have_content('Pick an aviable item for your selected date: 2021-04-21 00:00:00 UTC')
    end

    scenario "pick a valid date, submit, reserve" do
        visit new_account_session_path
        login_as_dummy_user
        create_dummy_equipment
        visit reservations_path
        expect(page).to have_content('Select a Date for Reservation')
        page.find('#reservation_checkout_date').set("04-21-2021")
        page.find('#reservation_checkout_date').set("Big Party")
        click_button 'Pick Date'
        expect(page).to have_content('Pick an aviable item for your selected date: 2021-04-21 00:00:00 UTC')
        click_link 'Reserve'
        expect(page).to have_content('Notice: Reservation Complete!')
        expect(page).to have_content('DJ Decks')
    end

    scenario "pick a valid date, submit, reserve, cancel" do
        visit new_account_session_path
        login_as_dummy_user
        create_dummy_equipment
        visit reservations_path
        expect(page).to have_content('Select a Date for Reservation')
        page.find('#reservation_checkout_date').set("04-21-2021")
        page.find('#reservation_checkout_date').set("Big Party")
        click_button 'Pick Date'
        expect(page).to have_content('Pick an aviable item for your selected date: 2021-04-21 00:00:00 UTC')
        click_link 'Reserve'
        expect(page).to have_content('Notice: Reservation Complete!')
        expect(page).to have_content('DJ Decks')
        click_link 'Cancel'
        expect(page).to have_content('Notice: Reservation Cancelled!')
    end

    scenario "reserve same day as someone else" do
        visit new_account_session_path
        login_as_dummy_user
        create_dummy_equipment
        visit reservations_path
        expect(page).to have_content('Select a Date for Reservation')
        page.find('#reservation_checkout_date').set("04-21-2021")
        page.find('#reservation_checkout_date').set("Big Party")
        click_button 'Pick Date'
        expect(page).to have_content('Pick an aviable item for your selected date: 2021-04-21 00:00:00 UTC')
        click_link 'Reserve'
        expect(page).to have_content('Notice: Reservation Complete!')
        expect(page).to have_content('DJ Decks')

        visit reservations_path
        expect(page).to have_content('Select a Date for Reservation')
        page.find('#reservation_checkout_date').set("04-21-2021")
        page.find('#reservation_checkout_date').set("Big Party")
        click_button 'Pick Date'
        expect(page).to have_content('Pick an aviable item for your selected date: 2021-04-21 00:00:00 UTC')
        click_link 'Reserve'
        expect(page).to have_content('Notice: Equipment item is already reserved on your day!')
    end

    scenario "visit the equipment log" do
        user = Account.create(first_name: 'Bill', last_name: 'Nye', email: 'test@test.com', phone_number: '1112223333', secondary_contact: 'no@gmail.com', password: "password", password_confirmation: "password", is_admin: true)
        sign_in user
        create_dummy_equipment
        visit reservations_path
        expect(page).to have_content('Select a Date for Reservation')
        page.find('#reservation_checkout_date').set("04-21-2021")
        page.find('#reservation_checkout_date').set("Big Party")
        click_button 'Pick Date'
        expect(page).to have_content('Pick an aviable item for your selected date: 2021-04-21 00:00:00 UTC')
        click_link 'Reserve'
        expect(page).to have_content('Notice: Reservation Complete!')
        expect(page).to have_content('DJ Decks')

        visit reservations_reservation_log_path
        expect(page).to have_content('History Of Reservations')
        expect(page).to have_content('Bill Nye')
        expect(page).to have_content('DJ Decks')
        expect(page).to have_content('2021-04-21 00:00:00 UTC')
        expect(page).to have_content('2021-04-22 00:00:00 UTC')
    end

    scenario "admin cancelling reservation" do
        user = Account.create(first_name: 'Bill', last_name: 'Nye', email: 'test@test.com', phone_number: '1112223333', secondary_contact: 'no@gmail.com', password: "password", password_confirmation: "password", is_admin: true)
        sign_in user
        create_dummy_equipment
        visit reservations_path
        expect(page).to have_content('Select a Date for Reservation')
        page.find('#reservation_checkout_date').set("04-21-2021")
        page.find('#reservation_checkout_date').set("Big Party")
        click_button 'Pick Date'
        expect(page).to have_content('Pick an aviable item for your selected date: 2021-04-21 00:00:00 UTC')
        click_link 'Reserve'
        expect(page).to have_content('Notice: Reservation Complete!')
        expect(page).to have_content('DJ Decks')

        visit reservations_reservation_list_path
        expect(page).to have_content('Bill Nye')
        expect(page).to have_content('test@test.com')
        expect(page).to have_content('DJ Decks')
        expect(page).to have_content('2021-04-21 00:00:00 UTC')
        expect(page).to have_content('2021-04-22 00:00:00 UTC')
        click_link 'Cancel'
        expect(page).to have_content('Notice: Reservation Cancelled!')
    end
end