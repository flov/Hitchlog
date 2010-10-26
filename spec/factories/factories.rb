require 'factory_girl'

Factory.sequence :login do |n|
  "user#{n}"
end

Factory.sequence :email do |n|
  "gandhi_#{n}@localhost.com"
end

Factory.sequence :name do |n|
  "Teambox ##{n}"
end


Factory.define :user do |user|
  user.login         { Factory.next :login }
  user.email         { Factory.next :email }
end
