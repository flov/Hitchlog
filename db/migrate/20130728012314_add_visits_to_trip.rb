class AddVisitsToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :visits, :integer, default: 0
  end
end
