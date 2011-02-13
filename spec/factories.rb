require 'factory_girl'

Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |user|
  user.email                 { Factory.next :email }
  user.username              { |u| u.email.split("@").first }
  user.password              { "password" }
  user.password_confirmation { "password" }
end

Factory.define :alex, :parent => :user do |user|
  user.username 'alex'
  user.email 'alexander.supertramp@hitchhike.me'
end

Factory.define :trip do |trip|
  trip.from  { 'Barcelona' }
  trip.to    { 'Madrid' }
  trip.start { '22/11/2009' }
  trip.duration { '6'}
  trip.association(:user)
end

Factory.define :hitchhike do |hitchhike|
  hitchhike.title{'A hitchhike around the world'}
  hitchhike.story{'A crazy new story about hitchhiking'}
  hitchhike.waiting_time{15}
  hitchhike.duration{4}
  hitchhike.association(:trip)
  hitchhike.person {|h| h.association(:person)}
end

Factory.define :person do |person|
  person.name         {'Penny Lane'}
  person.occupation   {'Groupie'}
  person.mission      {'Tour around with the Beatles'}
  person.origin       {'USA'}
  person.age          {21}
  person.gender       {'female'}
end

Factory.define :address_not_routable_hitchhike, :parent => :hitchhike do |f|
  f.from { 'Kabul' }
  f.to   { 'New Delhi' }
end
