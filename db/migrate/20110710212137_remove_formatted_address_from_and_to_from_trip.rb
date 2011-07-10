class RemoveFormattedAddressFromAndToFromTrip < ActiveRecord::Migration
  def self.up
    remove_column :trips, :formatted_from
    remove_column :trips, :formatted_to
    Trip.all.each {|t| t.get_formatted_addresses! }
  end

  def self.down
    add_column :trips, :formatted_from, :string
    add_column :trips, :formatted_to, :string
  end
end
