class AddSignInAddressForEachExistingUser < ActiveRecord::Migration
  def self.up
    User.all.each do |user|
      user.geocode_address
      user.save!
    end
  end

  def self.down
  end
end
