class AddDescriptionToFutureTrip < ActiveRecord::Migration
  def change
    add_column :future_trips, :description, :text
  end
end
