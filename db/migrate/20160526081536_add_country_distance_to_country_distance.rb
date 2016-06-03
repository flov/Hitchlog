class AddCountryDistanceToCountryDistance < ActiveRecord::Migration
  def change
    add_column :country_distances, :country_code, :string
  end
end
