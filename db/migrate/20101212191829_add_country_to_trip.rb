class AddCountryToTrip < ActiveRecord::Migration
  def self.up
    add_column :trips, :from_country, :string
    add_column :trips, :to_country, :string
    
    add_index(:users, :username)
  end

  def self.down
    remove_column :trips, :to_country
    remove_column :trips, :from_country
    
    remove_index(:users, :username)
  end
end
