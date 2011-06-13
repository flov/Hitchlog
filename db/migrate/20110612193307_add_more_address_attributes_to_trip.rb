class AddMoreAddressAttributesToTrip < ActiveRecord::Migration
  def self.up
    add_column :trips, :from_postal_code, :string
    add_column :trips, :from_street, :string
    add_column :trips, :from_street_no, :string
                     
    add_column :trips, :to_postal_code, :string
    add_column :trips, :to_street, :string
    add_column :trips, :to_street_no, :string
  end

  def self.down
    remove_column :trips, :from_postal_code
    remove_column :trips, :from_street
    remove_column :trips, :from_street_no

    remove_column :trips, :to_postal_code
    remove_column :trips, :to_street
    remove_column :trips, :to_street_no
  end
end
