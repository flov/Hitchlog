class AddTripIdToHitchhike < ActiveRecord::Migration
  def self.up
    add_column :hitchhikes, :trip_id, :integer
  end

  def self.down
    remove_column :hitchhikes, :trip_id
  end
end
