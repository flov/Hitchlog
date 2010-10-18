Factory.sequence :login do |n|
  "user#{n}"
end

Factory.define :user do |user|
  user.login                 { Factory.next :email }
end
