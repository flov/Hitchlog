class AddTravellingWithIndexToTrip < ActiveRecord::Migration
  def change
    add_index(:trips, :travelling_with)
  end
end
