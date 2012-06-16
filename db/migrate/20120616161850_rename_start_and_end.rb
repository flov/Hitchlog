class RenameStartAndEnd < ActiveRecord::Migration
  def up
    rename_column(:trips, :start, :departure)
    rename_column(:trips, :end,   :arrival)
  end

  def down
    rename_column(:trips, :departure, :start)
    rename_column(:trips, :arrival, :end)
  end
end
