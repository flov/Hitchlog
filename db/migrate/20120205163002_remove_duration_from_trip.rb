class RemoveDurationFromTrip < ActiveRecord::Migration
  def up
    remove_column :trips, :duration
  end

  def down
    add_column :trips, :duration, :integer
  end
end
