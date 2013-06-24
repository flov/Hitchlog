class SanitizeDepartureAndArrivalForOldTrips < ActiveRecord::Migration
  def up
    Trip.where("departure is null").each do |trip|
     trip.update_column :departure, 3.years.ago 
     trip.update_column :arrival, 3.years.ago + 5.hours
    end
  end
end
