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

Factory.define :hitchhike do |hitchike|
  hitchike.from  { 'Barcelona' }
  hitchike.to    { 'Madrid' }
  hitchike.title { 'example title' }
  hitchike.story { 'example story' }
  hitchike.association(:user)
end

Factory.define :person do |person|
  person.name         {'Penny Lane'}
  person.occupation   {'Groupie'}
  person.mission      {'Tour around with the Beatles'}
  person.origin       {'USA'}
  person.association  (:hitchhike)
  person.age          {21}
  person.gender       {'female'}
end

Factory.define :address_not_found_hitchhike, :parent => :hitchhike do |f|
  f.from { 'geez this is not an address' }
  f.to   { 'and this is not an address either' }
end

Factory.define :address_not_routable_hitchhike, :parent => :hitchhike do |f|
  f.from { 'Kabul' }
  f.to   { 'New Delhi' }
end