class AddGmapsCityToTrips < ActiveRecord::Migration
  def self.up
    add_column :trips, :from_city, :string
    add_column :trips, :to_city, :string
  end

  def self.down
    remove_column :trips, :to_city
    remove_column :trips, :from_city
  end
end
