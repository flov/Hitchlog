class AddGenderToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :gender, :string
  end

  def self.down
    remove_column :people, :gender
  end
end
