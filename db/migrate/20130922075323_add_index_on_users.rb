class AddIndexOnUsers < ActiveRecord::Migration
  def change
    add_index :users, :location
    add_index :users, :country
  end
end
