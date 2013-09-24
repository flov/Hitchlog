class AddAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :date_of_birth, :date
    add_column :users, :languages, :string
    add_column :users, :origin, :string
  end
end
