puts <<-EOS
This will create some example users and a pre-populated project for development.
EOS

def seed_data
  puts "Seeding Users"
  users = %w(Flov Supertramp Helen).collect do |username|
    user = User.finde_by_username(username) || User.create!(
                        :username => 'flov',
                        :password => 'adminadmin',
                        :password_confirmation => 'testpassword',
                        :email    => "#{username}@hitchlog.com")
  
  end

  
  User.find_by_username("flov").trips.build(
    
end


seed_data
