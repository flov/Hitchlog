class AddUserIdToTrip < ActiveRecord::Migration
  def self.up
    add_column :trips, :user_id, :integer
  end

  def self.down
    remove_column :trips, :user_id
  end
end
