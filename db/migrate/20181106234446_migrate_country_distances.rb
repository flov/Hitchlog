class MigrateCountryDistances < ActiveRecord::Migration
  def change
    Trip.includes(:country_distances).where(country_distances: {trip_id: nil}).each do |trip|
      trip.get_country_distance
      puts "got country distance for #{trip.to_params}"
    end
  end
end
