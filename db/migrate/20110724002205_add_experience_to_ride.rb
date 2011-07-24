class AddExperienceToRide < ActiveRecord::Migration
  def self.up
    add_column :rides, :experience, :string, :default => 'positive'
  end

  def self.down
    remove_column :rides, :experience
  end
end
