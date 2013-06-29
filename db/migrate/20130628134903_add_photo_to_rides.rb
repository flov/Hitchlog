class AddPhotoToRides < ActiveRecord::Migration
  def change
    add_column :rides, :photo, :string
  end
end
