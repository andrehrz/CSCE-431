class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.datetime :checkout_date
      t.datetime :checkin_date
      t.string :event_description

      t.timestamps
    end
  end
end
