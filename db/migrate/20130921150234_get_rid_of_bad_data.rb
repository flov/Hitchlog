class GetRidOfBadData < ActiveRecord::Migration
  def up
    # ridiculouos trip, cannot have hitchhiked that one
    User.find('aussievswild').trips.first.destroy


    # Chinese users are hackers...
    User.where(country: 'China').each { |user| user.destroy }
  end

  def down
  end
end
