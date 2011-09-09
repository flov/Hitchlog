require 'factory_girl'

Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |user|
  user.email                 { Factory.next :email }
  user.username              { |u| u.email.split("@").first }
  user.password              "password"
  user.password_confirmation "password"
  user.last_sign_in_at        Time.zone.now
end

Factory.define :trip do |trip|
  trip.from  'Barcelona'
  trip.to 'Madrid'
  trip.start '22/11/2009'
  trip.duration 6
  trip.distance 1646989
  trip.user  {|u| u.association(:user)}
  trip.rides {|r| [r.association(:ride)]} 
  trip.hitchhikes 2
end

Factory.define :ride do |ride|
  ride.title 'Wow, what a ride'
  ride.story 'A crazy new story about hitchhiking'
  ride.waiting_time 15
  ride.duration 2
  ride.person {|h| h.association(:person)}
end

Factory.define :person do |person|
  person.name         'Penny Lane'
  person.occupation   'Groupie'
  person.mission      'Tour around with the Beatles'
  person.origin       'USA'
  person.age          21
  person.gender       'female'
end

Factory.define :address_not_routable_ride, :parent => :ride do |f|
  f.from  'Kabul' 
  f.to    'New Delhi' 
end
