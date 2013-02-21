class AddColumnsToFutureTrip < ActiveRecord::Migration
  def change
    add_column :future_trips, :from_lng, :float
    add_column :future_trips, :from_lat, :float
    add_column :future_trips, :to_lng,   :float
    add_column :future_trips, :to_lat,   :float
  end
end
