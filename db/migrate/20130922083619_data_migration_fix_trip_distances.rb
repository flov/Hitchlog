require "#{Rails.root}/lib/gmaps"

class DataMigrationFixTripDistances < ActiveRecord::Migration
  def up
    Trip.where("distance = 1000 OR distance < 0").each do |trip|
      puts "UPDATING: #{trip}"
      trip.update_column :distance, Gmaps.distance(trip.from, trip.to)
      puts "UPDATED: #{trip}, from #{trip.from} to #{trip.to}, distance: #{trip.distance}"
    end
  end

  def down
  end
end
