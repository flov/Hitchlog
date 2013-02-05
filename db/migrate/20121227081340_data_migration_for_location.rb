class DataMigrationForLocation < ActiveRecord::Migration
  def up
    User.all.each do |user|
      if user.current_sign_in_ip == '127.0.0.1' or user.current_sign_in_ip.nil?
        next
      end

      if user.location.nil? and user.lat.present? and user.lng.present? and [user.lat, user.lng] != [0, 0]
        puts "Locating `#{user}` (#{user.id})..."
        results = Geocoder.search("#{user.lat},#{user.lng}")
        user.location = "#{results[0].city}, #{results[0].country}"
        user.city = results[0].city
        user.country = results[0].country
        user.country_code = results[0].country_code
        puts "Location: #{user.location}"
        puts "City: #{user.city}"
        puts "Country: #{user.country}"
        puts "Countrycode: #{user.country_code}"
        user.save!

        user.update_column(:location_updated_at, user.current_sign_in_at)
        puts "Location updated at: #{user.location_updated_at.strftime("%d %b %y")}"
        puts "-------------------"
        sleep 1
      elsif user.location_updated_at.nil? and user.lat.present? and user.lng.present?
        puts "Updated location updated at: #{user.country_code.strftime("%d %b %y")}"
        puts "-------------------"
      elsif user.lat.blank? and user.lng.blank?
        puts "#{user} (#{user.id}) does not have any lat or lng, trying to parse ip..."
        results = Geocoder.search(user.current_sign_in_ip)
        user.location = "#{results[0].city}, #{results[0].country}"
        user.city = results[0].city
        user.country = results[0].country
        user.country_code = results[0].country_code
        puts "Location: #{user.location}"
        puts "City: #{user.city}"
        puts "Country: #{user.country}"
        puts "Countrycode: #{user.country_code}"
        user.save!

        user.update_column(:location_updated_at, user.current_sign_in_at)
        puts "Location updated at: #{user.location_updated_at.strftime("%d %b %y")}"
        puts "-------------------"

        sleep 1
      else
        puts "#{user} has the location already set up"
        puts "-------------------"
      end
    end
  end

  def down
  end
end
