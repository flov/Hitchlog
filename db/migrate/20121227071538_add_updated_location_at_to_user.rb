class AddUpdatedLocationAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :location_updated_at, :datetime
  end
end
