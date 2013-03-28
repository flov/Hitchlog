class MigrateFacebookUsernames < ActiveRecord::Migration
  def up
    User.where("username like '%.%'").each do |user|
      user.username = user.username.gsub(".", '_')
      user.save!
    end
  end

  def down
  end
end
