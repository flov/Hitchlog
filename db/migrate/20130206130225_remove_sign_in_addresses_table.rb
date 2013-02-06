class RemoveSignInAddressesTable < ActiveRecord::Migration
  def change
    drop_table :sign_in_addresses
  end
end
