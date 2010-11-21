class AddUserIdToHitchhike < ActiveRecord::Migration
  def self.up
    add_column :hitchhikes, :user_id, :integer
  end

  def self.down
    remove_column :hitchhikes, :user_id
  end
end
