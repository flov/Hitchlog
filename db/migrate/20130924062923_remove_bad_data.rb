class RemoveBadData < ActiveRecord::Migration
  def up
    Trip.where('distance < 0').each do |trip|
      trip.update_column :distance, 0
    end
  end

  def down
  end
end
