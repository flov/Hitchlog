class RemoveDefaultOnVehicle < ActiveRecord::Migration
  def up
    remove_column :rides, :vehicle
    add_column :rides, :vehicle, :string
  end

  def down
    remove_column :rides, :vehicle
    add_column :rides, :vehicle, :string
  end
end
