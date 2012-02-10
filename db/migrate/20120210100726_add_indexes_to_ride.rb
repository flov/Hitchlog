class AddIndexesToRide < ActiveRecord::Migration
  def change
    add_index :rides, :gender
    add_index :rides, :experience
    add_index :rides, :trip_id
    add_index :rides, :user_id
  end
end
