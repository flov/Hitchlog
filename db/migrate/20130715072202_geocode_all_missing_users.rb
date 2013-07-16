class GeocodeAllMissingUsers < ActiveRecord::Migration
  def up
    User.where('users.lat is null').where('current_sign_in_ip is not null').all.each do |user|
      user.geocode
      user.reverse_geocode
      puts "Updating #{user}:"
      puts "lat #{user.lat}, lng #{user.lng}, city #{user.city}, country #{user.country}:"
      user.save
    end
    User.where('lat is not null').where('current_sign_in_ip is not null').all.each do |user|
      user.reverse_geocode
      puts "Updating #{user}:"
      puts "city #{user.city}, country #{user.country}:"
      user.save
    end
  end
end
