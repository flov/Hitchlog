class AddDateToHitchhike < ActiveRecord::Migration
  def self.up
    add_column :hitchhikes, :date, :datetime
  end

  def self.down
    remove_column :hitchhikes, :date
  end
end
