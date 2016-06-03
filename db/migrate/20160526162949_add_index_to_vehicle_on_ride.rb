class AddIndexToVehicleOnRide < ActiveRecord::Migration
  def change
    add_index :rides, :vehicle
  end
end
