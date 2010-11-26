Given /^there is a hitchhike from ([^\"]*)$/ do |username|
  puts username
  user = User.find_by_username(username)
  a = Factory.new(:hitchhike, :user_id => user.user_id)
  puts a.from
end

Then /^I should see the hitchhike of Alexander but not the other one$/ do
  pending # express the regexp above with the code you wish you had
end
