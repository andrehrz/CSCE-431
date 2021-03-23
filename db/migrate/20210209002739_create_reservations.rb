class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.belongs_to :account
      #t.has_one :equipment
      t.bigint :future_equip_id
      t.datetime :checkout_date
      t.datetime :checkin_date
      t.string :event_description
      t.string :saved_item
      t.string :renter_name

      t.timestamps
    end
  end
end
