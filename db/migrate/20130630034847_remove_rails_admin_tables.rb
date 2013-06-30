class RemoveRailsAdminTables < ActiveRecord::Migration
  def up
    drop_table :rails_admin_histories
  end
end
