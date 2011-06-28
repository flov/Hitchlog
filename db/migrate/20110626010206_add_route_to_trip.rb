class AddRouteToTrip < ActiveRecord::Migration
  def self.up
    add_column :trips, :route, :text
  end

  def self.down
    remove_column :trips, :route
  end
end
