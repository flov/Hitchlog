class AddStoryToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :story, :text
  end
end
