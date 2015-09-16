class ChangeDefaultExperienceOfRide < ActiveRecord::Migration
  def up
    change_column_default(:rides, :experience, 'good')
  end

  def down
  end
end
