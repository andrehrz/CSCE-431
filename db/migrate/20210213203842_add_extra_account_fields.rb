class AddExtraAccountFields < ActiveRecord::Migration[6.1]

  def change
    add_column :accounts, :violation_counter, :integer, :default => 0
  end
end
