require 'rails_helper'

RSpec.describe Equipment, type: :model do
    context 'validation tests' do

        it 'ensures name is present' do
            equip_item = Equipment.new(description: 'Speakers', available: true).save
            expect(equip_item).to eq(false)
        end

        it 'ensures description is present' do
            equip_item = Equipment.new(name: 'Traktor Decks', available: true).save
            expect(equip_item).to eq(false)
        end
        
        it 'ensures available boolean is present' do
            equip_item = Equipment.new(name: 'Traktor Decks', description: 'Speakers').save
            expect(equip_item).to eq(false)
        end

    end

    context 'scopes tests' do

        let (:params) {{name: 'Traktor Decks', description: 'Speakers', available: true}}

        before(:each) do
            Equipment.new(params).save
            Equipment.new(params).save
            Equipment.new(name: 'Traktor Decks', description: 'Speakers', available: false).save
            Equipment.new(name: 'Traktor Decks', description: 'Speakers', available: false).save
            Equipment.new(name: 'Traktor Decks', description: 'Speakers', available: false).save
        end

        it 'should return avail equipment' do
            expect(Equipment.avail_items.size).to eq(2)
        end

        it 'should return non avail equipment' do
            expect(Equipment.not_avail_items.size).to eq(3)
        end
    end
end