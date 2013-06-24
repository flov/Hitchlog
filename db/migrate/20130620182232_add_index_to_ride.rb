class AddIndexToRide < ActiveRecord::Migration
  def change
    add_index :rides, :number
  end
end
