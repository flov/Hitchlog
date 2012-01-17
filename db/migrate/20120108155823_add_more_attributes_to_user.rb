class AddMoreAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :about_you, :text
    add_column :users, :cs_user,   :string
  end
end
