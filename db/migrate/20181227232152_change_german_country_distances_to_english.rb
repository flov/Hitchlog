class ChangeGermanCountryDistancesToEnglish < ActiveRecord::Migration
  def change
    without_country_code = CountryDistance.where("country_code is NULL")
    without_country_code.each do |cd|
      cd.country_code = Countries[cd.country]
      cd.save
      print ('.')
    end
    puts ''
    puts "Changed #{without_country_code.count} Countries to have a country code"

    [
      ['Brasilien', 'Brazil'],
      ['Holandia', 'The Netherlands'],
      ['Niemcy', 'Germany'],
      ['Słowenia', 'Slovenia'],
      ['Polska', 'Poland'],
      ['Poljska', 'Poland'],
      ['Czechia', 'Czech Republic'],
      ['Brunei', 'Brunei Darussalam'],
      ['Slovenija', 'Slovenia'],
      ['Deutschland', 'Germany']
    ].each do |array|
      CountryDistance.where(country: array.first).each do |cd|
        cd.country = array.last
        cd.country_code = Countries[array.last]
        cd.save
        print ('.')
      end
    end

    puts ''
    puts "Changed foreign language countries to english again"
  end
end
