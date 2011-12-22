class MigrateStoryDataToTrip < ActiveRecord::Migration
  def up
    Trip.all.each do |trip|
      story = trip.rides.map(&:story).join(" ").strip
      unless story.empty?
        trip.story = story 
        trip.save!
      end
    end
  end

  def self.down
    Trip.all.each{|trip| trip.story = nil; trip.save!}
  end
end
