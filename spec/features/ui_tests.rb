require 'rails_helper'

RSpec.describe 'Login Page Tests', type: :feature do
    describe 'login page' do
        it 'shows log in text' do
            visit new_account_session_path
            expect(page).to have_content('Log in')
        end

        it 'shows email text and field' do
            visit new_account_session_path
            expect(page).to have_content('Email')
            expect(page).to have_field('Email')
            expect(find_field('Email').value).to eq ''
        end
        
        it 'shows password text and field' do
            visit new_account_session_path
            expect(page).to have_content('Password')
            expect(page).to have_field('Password')
            expect(find_field('Password').value).to eq ''
        end

        # it 'shows remember me text and button' do
        #     visit new_account_session_path
        #     expect(page).to have_content('Remember me')
        #     expect(page).to have_button('Remember me')
        # end

        it 'has login submit button' do 
            visit new_account_session_path
            expect(page).to have_button('Log in')
        end
        
        it 'has sign up link' do 
            visit new_account_session_path
            expect(page).to have_link('Sign up')
        end

        it 'has forgot password link' do 
            visit new_account_session_path
            expect(page).to have_link('Forgot your password?')
        end
    end
end

RSpec.describe 'Sign Up Page Tests', type: :feature do
    describe 'sign up page' do
        it 'shows sign up text' do
            visit new_account_registration_path
            expect(page).to have_content('Sign up')
        end

        it 'shows first name text and field' do
            visit new_account_registration_path
            expect(page).to have_content('First name')
            expect(page).to have_field('First name')
            expect(find_field('First name').value).to eq ''
        end

        it 'shows last name text and field' do
            visit new_account_registration_path
            expect(page).to have_content('Last name')
            expect(page).to have_field('Last name')
            expect(find_field('Last name').value).to eq ''
        end

        it 'shows email name text and field' do
            visit new_account_registration_path
            expect(page).to have_content('Email')
            expect(page).to have_field('Email')
            expect(find_field('Email').value).to eq ''
        end

        it 'shows phone number text and field' do
            visit new_account_registration_path
            expect(page).to have_content('Phone number')
            expect(page).to have_field('Phone number')
            expect(find_field('Phone number').value).to eq ''
        end

        it 'shows phone number text and field' do
            visit new_account_registration_path
            expect(page).to have_content('Phone number')
            expect(page).to have_field('Phone number')
            expect(find_field('Phone number').value).to eq ''
        end

        it 'shows secondary contact text and field' do
            visit new_account_registration_path
            expect(page).to have_content('Secondary contact')
            expect(page).to have_field('Secondary contact')
            expect(find_field('Secondary contact').value).to eq ''
        end

        it 'shows password text and field' do
            visit new_account_registration_path
            expect(page).to have_content('Password')
            expect(page).to have_field('Password')
            expect(find_field('Password').value).to eq ''
        end

        it 'shows password confirmation text and field' do
            visit new_account_registration_path
            expect(page).to have_content('Password confirmation')
            expect(page).to have_field('Password confirmation')
            expect(find_field('Password confirmation').value).to eq ''
        end

        it 'has login submit button' do 
            visit new_account_registration_path
            expect(page).to have_button('Sign up')
        end
        
        it 'has sign up link' do 
            visit new_account_registration_path
            expect(page).to have_link('Log in')
        end
    end
end

# RSpec.describe 'Home Page Tests', type: :feature do
#     describe 'home page' do
#         it 'shows title text' do
#             visit root_path
#             expect(page).to have_content('Home Page')
#         end
#     end
# end