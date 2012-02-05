class AddCaptionToPhoto < ActiveRecord::Migration
  def change
    add_column :rides, :photo_caption, :string
  end
end
