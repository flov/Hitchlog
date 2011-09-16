class AddLatAndLngToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :sign_in_lat, :float
    add_column :users, :sign_in_lng, :float
  end

  def self.down
    remove_column :users, :sign_in_lng
    remove_column :users, :sign_in_lat
  end
end
