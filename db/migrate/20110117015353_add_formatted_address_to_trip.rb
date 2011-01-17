class AddFormattedAddressToTrip < ActiveRecord::Migration
  def self.up
    add_column :trips, :formatted_from, :string
    add_column :trips, :formatted_to, :string
  end

  def self.down
    remove_column :trips, :formatted_to
    remove_column :trips, :formatted_from
  end
end
