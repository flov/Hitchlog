class AddFormattedAddressToTrip < ActiveRecord::Migration
  def self.up
    add_column :trips, :from_formatted_address, :string
    add_column :trips, :to_formatted_address, :string
  end

  def self.down
    remove_column :trips, :to_formatted_address
    remove_column :trips, :from_formatted_address
  end
end
