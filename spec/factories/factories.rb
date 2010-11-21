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

Factory.define :flov, :parent => :user do |user|
  user.username 'flov'
  user.email 'florian.vallen@gmail.com'
end

Factory.define :hitchhike do |f|
  f.title { 'example title' }
  f.from  { 'Barcelona' }
  f.to    { 'Madrid' }
end

Factory.define :address_not_found_hitchhike, :parent => :hitchhike do |f|
  f.from { 'geez this is not an address' }
  f.to   { 'and this is not an address either' }
end

Factory.define :address_not_routable_hitchhike, :parent => :hitchhike do |f|
  f.from { 'Kabul' }
  f.to   { 'New Delhi' }
end