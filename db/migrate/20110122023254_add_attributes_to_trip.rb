class AddAttributesToTrip < ActiveRecord::Migration
  def self.up
    add_column :trips, :money_spent, :integer
    add_column :trips, :travelling_with, :integer
  end

  def self.down
    remove_column :trips, :money_spent
    remove_column :trips, :travelling_with
  end
end
