class SignInAddress < ActiveRecord::Base
  belongs_to :user
end

class MoveSignInAddaressData < ActiveRecord::Migration
  def up
    SignInAddress.all.each do |sign_in_address|
      unless sign_in_address.user.nil?
        sign_in_address.user.update_column(:city, sign_in_address.city)
        sign_in_address.user.update_column(:country, sign_in_address.country)
        sign_in_address.user.update_column(:country_code, sign_in_address.country_code)
      end
    end
  end

  def down
  end
end
