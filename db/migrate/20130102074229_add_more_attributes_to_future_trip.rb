class AddMoreAttributesToFutureTrip < ActiveRecord::Migration
  def change
    add_column :future_trips, :from_city, :string
    add_column :future_trips, :from_country_code, :string
    add_column :future_trips, :from_country, :string
    add_column :future_trips, :to_city, :string
    add_column :future_trips, :to_country_code, :string
    add_column :future_trips, :to_country, :string
  end
end
