class AddTitleIndexToRide < ActiveRecord::Migration
  def change
    add_index :rides, :title
  end
end
