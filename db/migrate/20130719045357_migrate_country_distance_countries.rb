class MigrateCountryDistanceCountries < ActiveRecord::Migration
  def up
    CountryDistance.where(country: "Netherlands").each do |cd|
      puts "changing `#{cd.country}` to `The Netherlands`"
      cd.update_column :country, 'The Netherlands'
    end

    CountryDistance.where(country: "Kingdom of Sweden").each do |cd|
      puts "changing country `#{cd.country}` to `Sweden`"
      cd.update_column :country, 'Sweden'
    end
  end

  def down
  end
end
