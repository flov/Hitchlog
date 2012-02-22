require 'factory_girl'
require 'faker'

Factory.sequence :email do |n|
  "testuser#{n}@example.com"
end

Factory.define :sign_in_address do |sign_in_address|
end

Factory.define :user do |user|
  user.email                 { Factory.next :email }
  user.username              { |u| u.email.split("@").first }
  user.password              "password"
  user.password_confirmation "password"
  user.cs_user               Faker::Name.first_name
  user.last_sign_in_at       Time.zone.now
  user.sign_in_lat           0.0          # if tested offline
  user.sign_in_lng           0.0          # it must not be null for tests
  user.association           :sign_in_address
end

Factory.define :munich_user, :parent => :user do |user|
  user.current_sign_in_ip "195.71.11.67"
end

Factory.define :berlin_user, :parent => :user do |user|
  user.current_sign_in_ip "88.73.54.0"
end

Factory.define :trip do |trip|
  trip.from 'Tehran'
  trip.to 'Shiraz'
  trip.start "07/12/2011 10:00"
  trip.end   "07/12/2011 20:00"
  trip.travelling_with 0
  trip.gmaps_duration   9.hours.to_f
  trip.distance 1646989
  trip.association(:user)
  trip.hitchhikes 1
end

Factory.define :ride do |ride|
  ride.waiting_time 15
  ride.duration 2
  ride.association(:person)
end

Factory.define :person do |person|
  person.occupation   'Groupie'
  person.mission      'Tour around with the Beatles'
  person.origin       'USA'
end
