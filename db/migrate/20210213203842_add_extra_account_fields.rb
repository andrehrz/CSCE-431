class AddExtraAccountFields < ActiveRecord::Migration[6.1]
  def up
    add_column :accounts, :first_name, :string
    add_column :accounts, :last_name, :string
    add_column :accounts, :phone_number, :string
    add_column :accounts, :secondary_contact, :string
    add_column :accounts, :is_admin, :boolean, default: false 
  end

  def down
    remove_column :accounts, :first_name, :string
    remove_column :accounts, :last_name, :string
    remove_column :accounts, :phone_number, :string
    remove_column :accounts, :secondary_contact, :string
    remove_column :accounts, :is_admin, :boolean
  end
end


