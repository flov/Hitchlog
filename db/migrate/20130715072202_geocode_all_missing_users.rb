class GeocodeAllMissingUsers < ActiveRecord::Migration
  def up
    User.where('users.lat is null').where('current_sign_in_ip is not null').all.each do |user|
      user.geocode
      user.reverse_geocode
      user.save
    end
    User.where('lat is not null').where('current_sign_in_ip is not null').all.each do |user|
      user.reverse_geocode
      user.save
    end
  end
end
