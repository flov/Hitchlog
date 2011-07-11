class AddGmapsDurationToTrip < ActiveRecord::Migration
  def self.up
    add_column :trips, :gmaps_duration, :integer
  end

  def self.down
    remove_column :trips, :gmaps_duration
  end
end
