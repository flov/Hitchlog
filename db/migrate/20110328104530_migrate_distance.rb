class MigrateDistance < ActiveRecord::Migration def self.up
    Trip.all.each(&:get_country_distance)
  end

  def self.down
    CountryDistance.destroy_all
  end
end
