class MigrateCountryCodeForCountryDistance < ActiveRecord::Migration
  def up
    puts "Migrating #{CountryDistance.where(country_code: nil).size} CountryDistance records to save country_code"
    CountryDistance.where(country_code: nil).find_each do |cd|
      country_code = Countries[cd.country]
      cd.country_code = country_code
      if cd.save
        puts "Updated CountryDistance #{cd.id} with #{country_code}"
      end
    end
  end
end
