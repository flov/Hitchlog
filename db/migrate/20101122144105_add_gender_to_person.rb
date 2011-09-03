class AddGenderToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :gender, :string, :default => 'male'
  end

  def self.down
    remove_column :people, :gender
  end
end
