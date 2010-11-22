class AddAttributesToHitchhike < ActiveRecord::Migration
  def self.up
    add_column :hitchhikes, :waiting_time, :integer
    add_column :people,     :age, :integer
  end

  def self.down
    remove_column :hitchhikes, :waiting_time
    remove_column :people, :age
  end
end
