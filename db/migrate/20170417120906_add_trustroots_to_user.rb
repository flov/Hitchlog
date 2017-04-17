class AddTrustrootsToUser < ActiveRecord::Migration
  def change
    add_column :users, :trustroots, :string
  end
end
