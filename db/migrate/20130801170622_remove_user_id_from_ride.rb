class RemoveUserIdFromRide < ActiveRecord::Migration
  def up
    remove_column :rides, :user_id
  end

  def down
    add_column :rides, :user_id, :string
  end
end
