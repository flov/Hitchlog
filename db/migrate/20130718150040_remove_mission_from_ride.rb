class RemoveMissionFromRide < ActiveRecord::Migration
  def up
    remove_column :rides, :mission
  end

  def down
    add_column :rides, :mission, :string
  end
end
