class AddViolationCounter < ActiveRecord::Migration[6.1]
  def up
    add_column :accounts, :violation_counter, :integer, :default => 0
  end

  def down
    remove_column :accounts, :violation_counter, :integer, :default => 0
  end
end
