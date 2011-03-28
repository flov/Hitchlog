class AddCountryDistances < ActiveRecord::Migration
  def self.up
    create_table :country_distances do |t|
      t.integer :distance
      t.integer :trip_id
      t.string :country
    end
  end

  def self.down
    drop_table :country_distances
  end
end
