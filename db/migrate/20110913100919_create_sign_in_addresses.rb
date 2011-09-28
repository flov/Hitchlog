class CreateSignInAddresses < ActiveRecord::Migration
  def self.up
    drop_table :sign_in_addresses
    create_table :sign_in_addresses do |t|
      t.string :city
      t.string :country_code
      t.string :country
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :sign_in_addresses
  end
end
