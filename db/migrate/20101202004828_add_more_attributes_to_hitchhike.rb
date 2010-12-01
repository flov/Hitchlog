class AddMoreAttributesToHitchhike < ActiveRecord::Migration
  def self.up
    add_column :hitchhikes, :duration, :float
  end

  def self.down
    remove_column :hitchhikes, :duration
  end
end
