class AddCountryCodeToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :from_country_code, :string
    add_column :trips, :to_country_code, :string
  end
end
