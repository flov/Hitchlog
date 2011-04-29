Given /^there is a ride from ([^\"]*)$/ do |username|
  user = User.find_by_username(username)
  a = Factory.create(:ride)
end

Then /^I should see the hitchhike of Alexander but not the other one$/ do
  pending # express the regexp above with the code you wish you had
end
