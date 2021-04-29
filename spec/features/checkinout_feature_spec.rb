require 'rails_helper'

# Creates dummy user to use for login specs
def login_as_dummy_user
    login_as(FactoryBot.create(:account, first_name: 'Bill', last_name: 'Nye', email: 'thescienceguy@test.com', phone_number: '1112223333', secondary_contact: 'no@gmail.com', password: 'password', is_admin: true))
end

def login_as_real_user
    login_as(FactoryBot.create(:account, first_name: 'John', last_name: 'Scopes', email: 'tester@gmail.com', phone_number: '1112223333', secondary_contact: 'no@gmail.com', password: 'password', is_admin: false))
end

def create_dummy_equipment
    Equipment.create(name:"DJ Decks", description:"Decks", available:true)
end

RSpec.describe "Check Out / Check In Feature", type: :feature do
    scenario "pick a non taken item and perform checkin and out" do
        visit new_account_session_path
        login_as_dummy_user

        create_dummy_equipment

        visit equipments_equip_list_path
        click_link 'Check Out'
        click_on '<<'
        
        expect(page).to have_content('thescienceguy@test.com')

        click_link 'Check In'
        click_on '<<'
        expect(page).to have_no_content('thescienceguy@test.com')
    end

    scenario "pick a taken item" do
        visit new_account_session_path
        login_as_dummy_user

        create_dummy_equipment

        visit equipments_equip_list_path
        click_link 'Check Out'
        click_on '<<'
        click_on 'Sign Out'

        visit new_account_session_path
        login_as_real_user

        visit equipments_equip_list_path
        click_link 'Check Out'
        expect(page).to have_content('Notice: That item is already checked out!')
    end

    scenario "check in non taken item" do
        visit new_account_session_path
        login_as_dummy_user

        create_dummy_equipment

        visit equipments_equip_list_path
        click_link 'Check In'
        
        expect(page).to have_content('Notice: That item is not checked out or does not belong to you!')
    end

    # scenario "turn in overdue reservation" do
    #     visit new_account_session_path
    #     login_as_dummy_user

    #     equip_item = Equipment.create(name:"DJ Decks", description:"Decks", available:true)

    #     visit equipments_equip_list_path
    #     click_link 'Check Out'
    #     click_on '<<'
    #     expect(page).to have_content('thescienceguy@test.com')
        
    #     equip_item.reservation.checkin_date

    #     visit equipments_equip_list_path
    #     click_link 'Check In'
    #     expect(page).to have_no_content('thescienceguy@test.com')
    # end
end