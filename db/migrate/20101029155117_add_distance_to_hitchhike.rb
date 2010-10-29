class AddDistanceToHitchhike < ActiveRecord::Migration
  def self.up
    add_column :hitchhikes, :distance, :integer
  end

  def self.down
    remove_column :hitchhikes, :distance
  end
end
