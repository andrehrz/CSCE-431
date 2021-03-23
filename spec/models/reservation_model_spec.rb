require 'rails_helper'
require 'date'

RSpec.describe Reservation, type: :model do
    context 'validation tests' do

        it 'ensures account_id is present' do
            resv = Reservation.new(checkout_date: DateTime.now, checkin_date: (DateTime.now+7)).save
            expect(resv).to eq(false)
        end

        it 'ensures checkout_date is present' do
            resv = Reservation.new(account_id: 1, checkin_date: (DateTime.now+7)).save
            expect(resv).to eq(false)
        end

        it 'ensures checkin_date is present' do
            resv = Reservation.new(account_id: 1, checkout_date: DateTime.now).save
            expect(resv).to eq(false)
        end

        it 'should save successfully' do
            resv = Reservation.new(account_id: 1, checkout_date: DateTime.now, checkin_date: DateTime.now+7).save
            expect(resv).to eq(true)
         end
    end

    # context 'scopes tests' do
    #     let (:params) {{account_id: 1, checkout_date: DateTime.now, checkin_date: DateTime.now+7}}
    #     before(:each) do
    #         Reservation.new(params).save
    #         Reservation.new(params).save
    #     end

    #     it 'should return admin users' do
    #         expect(Reservation.admin_accounts.size).to eq(0)
    #     end

    #     it 'should return non admin users' do
    #         expect(Reservation.member_accounts.size).to eq(0)
    #     end
    # end
end