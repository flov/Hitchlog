class AddIndexesOnUser < ActiveRecord::Migration
  def change
    add_index(:users, :country)
    add_index(:users, :country_code)
    add_index(:users, :city)
  end
end
