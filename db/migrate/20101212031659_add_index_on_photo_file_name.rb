class AddIndexOnPhotoFileName < ActiveRecord::Migration
  def self.up
    add_index :hitchhikes, :photo_file_name
  end

  def self.down
    remove_index :hitchhikes, :photo_file_name
  end
end
