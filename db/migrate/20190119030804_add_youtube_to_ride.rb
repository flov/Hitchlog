class AddYoutubeToRide < ActiveRecord::Migration
  def change
    add_column :rides, :youtube, :string, limit: 11
    add_index :rides, :youtube
  end
end
