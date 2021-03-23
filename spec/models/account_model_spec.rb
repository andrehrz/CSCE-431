require 'rails_helper'

RSpec.describe Account, type: :model do
    context 'validation tests' do

        it 'ensures email is present' do
            account = Account.new(password: 'admin', first_name: 'Bobby', last_name: 'Johnson', phone_number: '5122638824', secondary_contact: 'bademail@gmail.com').save
            expect(account).to eq(false)
        end

        it 'ensures password is present' do
            account = Account.new(email: 'spamspamspam@gmail.com', first_name: 'Bobby', last_name: 'Johnson', phone_number: '5122638824', secondary_contact: 'bademail@gmail.com').save
            expect(account).to eq(false)
        end
        
        it 'ensures first_name is present' do
            account = Account.new(email: 'spamspamspam@gmail.com', password: 'admin', last_name: 'Johnson', phone_number: '5122638824', secondary_contact: 'bademail@gmail.com').save
            expect(account).to eq(false)
        end
        
        it 'ensures last_name is present' do
            account = Account.new(email: 'spamspamspam@gmail.com', password: 'admin', first_name: 'Bobby', phone_number: '5122638824', secondary_contact: 'bademail@gmail.com').save
            expect(account).to eq(false)
        end
        
        it 'ensures phone_number is present' do
            account = Account.new(email: 'spamspamspam@gmail.com', password: 'admin', first_name: 'Bobby', last_name: 'Johnson', secondary_contact: 'bademail@gmail.com').save
            expect(account).to eq(false)
        end

        it 'ensures secondary_contact is present' do
            account = Account.new(email: 'spamspamspam@gmail.com', password: 'admin', first_name: 'Bobby', last_name: 'Johnson', phone_number: '5122638824').save
            expect(account).to eq(false)
        end

        it 'should save successfully' do
            account = Account.new(email: 'spamspamspam@gmail.com', password: 'admin', first_name: 'Bobby', last_name: 'Johnson', phone_number: '5122638824', secondary_contact: 'bademail@gmail.com').save
         end
    end

    context 'scopes tests' do
        let (:params) {{email: 'something@gmail.com', password: 'admin', first_name: 'First', last_name: 'Last', phone_number: '5122638824', secondary_contact: 'bademail@gmail.com', is_admin: true}}
        before(:each) do
            Account.new(params).save
            Account.new(params).save
            Account.new(params.merge(is_admin: true)).save
            Account.new(params.merge(is_admin: true)).save
            Account.new(params.merge(is_admin: true)).save
        end

        it 'should return admin users' do
            expect(Account.admin_accounts.size).to eq(0)
        end

        it 'should return non admin users' do
            expect(Account.member_accounts.size).to eq(0)
        end
    end
end