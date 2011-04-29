class RenameHitchhikeToRide < ActiveRecord::Migration
  def self.up
    rename_table(:hitchhikes, :rides)
    rename_column(:people, :hitchhike_id, :ride_id)
  end

  def self.down
    rename_table(:rides, :hitchhikes)
    rename_column(:people, :ride_id, :hitchhike_id)
  end
end
