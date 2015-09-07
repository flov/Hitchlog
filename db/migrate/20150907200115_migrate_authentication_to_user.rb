class MigrateAuthenticationToUser < ActiveRecord::Migration
  def up
    Authentication.find_each do |authentication|
      user = authentication.user
      user.uid = authentication.uid
      user.provider = authentication.provider
      puts "#{user.username} -> #{user.uid}" if user.save!
    end
  end

  def down
  end
end
