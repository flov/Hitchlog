Given /^"([^"]*)" logged a future trip from "([^"]*)" to "([^"]*)" at the "([^"]*)"$/ do |username, from, to, departure|
  user = User.find_by_username(username) || FactoryGirl.create(:user, email: "#{username}@hitchlog.com", username: username)
  user.future_travels.create(from: from, to: to, departure: departure)

end

Then /^I should see the future trip from "([^"]*)" to "([^"]*)" in the profile page$/ do |from, to|
  FutureTravel.where from: from, to: to
end

Then /^all hitchhikers around "([^"]*)" should receive a notification email$/ do |city|
  pending
end

Then /^I should see the future trip from "([^"]*)" to "([^"]*)" in the profile page$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^"([^"]*)" should receive a notification email$/ do |username|
  user = User.find_by_username username
  unread_emails_for(user.email).size.should == parse_email_count(amount)
end

