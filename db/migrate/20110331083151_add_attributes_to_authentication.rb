class AddAttributesToAuthentication < ActiveRecord::Migration
  def self.up
    add_column :authentications, :custom_attributes, :string
  end

  def self.down
    remove_column :authentications, :custom_attributes
  end
end
