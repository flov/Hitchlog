class RenameSignInLatAndLng < ActiveRecord::Migration
  def up
    rename_column(:users, :sign_in_lat, :lat)
    rename_column(:users, :sign_in_lng, :lng)
  end

  def down
    rename_column(:users, :lat, :sign_in_lat)
    rename_column(:users, :lng, :sign_in_lng)
  end
end
