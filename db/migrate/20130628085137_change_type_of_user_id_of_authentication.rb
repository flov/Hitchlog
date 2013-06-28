class ChangeTypeOfUserIdOfAuthentication < ActiveRecord::Migration
  def up
   add_column :authentications, :user_id_backup, :integer
   Authentication.all.each do |authentication|
     authentication.update_column :user_id_backup, authentication.user_id
   end
   remove_column :authentications, :user_id
   add_column :authentications, :user_id, :integer
   Authentication.all.each do |authentication|
     authentication.update_column :user_id, authentication.user_id_backup
   end
   remove_column :authentications, :user_id_backup
  end
end
