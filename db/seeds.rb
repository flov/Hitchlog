#puts <<-EOS
#This will create some example users and a pre-populated project for development.
#EOS

#def seed_data
  #puts "Seeding Users"
  #users = %w(Flov Supertramp).collect do |username|
    #user = User.find_by_username(username) || User.create!(
                        #:username => username,
                        #:password => 'adminadmin',
                        #:password_confirmation => 'adminadmin',
                        #:email    => "#{username}@hitchlog.com")
  #end

  #trips = [%w(Barcelona Valencia 09/02/2011 2 1),
           #%w(Rome Milano 02/03/2010 4 1),
           #%w(Pontferrada Barcelona 09/05/2010 4 2)].collect do |from,to,start,rides,travelling_with|
    #User.find_by_username("flov").trips.build(
      #"from" => "Barcelona",
      #"to"   => "Valencia", 
      #"start"=> "#{start} 06:00", 
      #"end"  => "#{start} 13:00", 
      #"rides"=> rides, 
      #"travelling_with" => travelling_with, 
      #"money_spent" => "5")
  #end

  
#end


#seed_data
