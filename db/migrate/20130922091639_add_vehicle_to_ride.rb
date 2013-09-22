class AddVehicleToRide < ActiveRecord::Migration
  def change
    add_column :rides, :vehicle, :string, default: 'car'
  end
end
