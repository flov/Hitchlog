class DataMigrationNoDepartureNullFields < ActiveRecord::Migration
  def up
    Trip.where('arrival is null').each do |trip|
      trip.arrival = trip.departure + 8.hours
      trip.save!
    end
  end
end
