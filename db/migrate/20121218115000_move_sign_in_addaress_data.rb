class MoveSignInAddaressData < ActiveRecord::Migration
  def up
    SignInAddress.all.each do |sign_in_address|
      sign_in_address.user.update_column(:city, sign_in_address.city)
      sign_in_address.user.update_column(:country, sign_in_address.country)
      sign_in_address.user.update_column(:country_code, sign_in_address.country_code)
    end

    drop_table :sign_in_addresses
  end

  def down
  end
end
