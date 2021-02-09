class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :phone_number
      t.integer :emergency_contact
      t.string :user_name
      t.string :password
      t.boolean :is_admin

      t.timestamps
    end
  end
end
