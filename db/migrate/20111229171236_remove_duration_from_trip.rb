class RemoveDurationFromTrip < ActiveRecord::Migration
  def change
    remove_column :trips, :duration
  end
end
