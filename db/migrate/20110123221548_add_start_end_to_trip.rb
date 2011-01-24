class AddStartEndToTrip < ActiveRecord::Migration
  def self.up
    add_column :trips, :end, :datetime
    rename_column :trips, :date, :start
  end

  def self.down
    rename_column :trips, :start, :datetime
    remove_column :trips, :end
  end
end
