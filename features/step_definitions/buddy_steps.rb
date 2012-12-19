Given /^"([^"]*)" logged a future trip from "([^"]*)" to "([^"]*)" at the "([^"]*)"$/ do |username, from, to, departure|
  user = User.find_by_username(username) || FactoryGirl.create(:user, email: "#{username}@hitchlog.com", username: username)
  user.future_travels.create(from: from, to: to, departure: departure)
end
