class AddIndexesToTrip < ActiveRecord::Migration
  def self.up
    add_index(:trips, :from_country)
    add_index(:trips, :to_country)
  end

  def self.down
    remove_index(:trips, :from_country)
    remove_index(:trips, :to_country)
  end
end
