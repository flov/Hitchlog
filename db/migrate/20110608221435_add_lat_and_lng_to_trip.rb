class AddLatAndLngToTrip < ActiveRecord::Migration
  def self.up
    add_column :trips, :to_lng, :float
    add_column :trips, :to_lat, :float
    add_column :trips, :from_lng, :float
    add_column :trips, :from_lat, :float
  end

  def self.down
    remove_column :trips, :from_lat
    remove_column :trips, :from_lng
    remove_column :trips, :to_lat
    remove_column :trips, :to_lng
  end
end
