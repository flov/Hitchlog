class MigrateDurationToEndToTrip < ActiveRecord::Migration
  def up
    Trip.where("duration IS NOT NULL AND start IS NOT NULL").each do |trip|
      trip.end = trip.start + (trip.duration*60*60)
      trip.save!
    end
  end

  def down
    Trip.where("duration IS NOT NULL").each do |trip|
      trip.duration = nil
      trip.save!
    end
  end
end
