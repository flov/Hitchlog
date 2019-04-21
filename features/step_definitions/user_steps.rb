Given /^a hitchhiker$/ do
  @user = FactoryGirl.create :user
  @user.confirm
end

Given /^a hitchhiker called "([^"]*)"$/ do |username|
  @user = FactoryGirl.create :user, username: username.downcase, email: "#{username}@test.com"
  @user.confirm
end

Given /^a hitchhiker called "([^"]*)" from "([^"]*)"$/ do |username, city|
  user = FactoryGirl.create :user, username: username
  user.update_column :city, city
end

Given /^a hitchhiker from "([^"]*)"$/ do |city|
  FactoryGirl.create :user, city: city, location: city
end

Given /^his CS user is "([^"]*)"$/ do |cs_username|
  @user.cs_user = cs_username
  @user.save!
end

Given /^I am logged in$/ do
  user = FactoryGirl.create(:user, username: 'flo')
  user.confirm
  visit new_user_session_path
  fill_in "Username", with: user.username
  fill_in "Password", with: 'password'
  click_button "Hitch in"
end

Given /^I am logged in as "([^"]*)"$/ do |username|
  user = User.find_by_username(username) || FactoryGirl.create(:user, email: "#{username}@hitchlog.com", username: username) unless @user
  user.confirm
  visit new_user_session_path
  fill_in "Username", with: user.username
  fill_in "Password", with: 'password'
  click_button "Hitch in"
end

Given /^I am logged in as "([^"]*)" from "([^"]*)"$/ do |username, city|
  user = FactoryGirl.build(:user, email: "#{username}@hitchlog.com", username: username, city: city)
  user.save!
  user.confirm

  visit new_user_session_path
  fill_in "Username", with: username
  fill_in "Password", with: 'password'
  click_button "Hitch in"
end

Given /^I logged a trip$/ do
  user ||= User.last
  user.trips << FactoryGirl.create(:trip)
end

When /^I sign up as "([^"]*)"$/ do |username|
  fill_in "user_username", with: username
  fill_in "Email", with: "#{username}@hitchlog.com"
  fill_in "user_password", with: 'password'
  fill_in "Password confirmation", with: 'password'
  select  "male", from: "Gender"
  click_button "Sign up"
end

Given /^(\d+) hitchhikers$/ do |number|
  number.to_i.times { FactoryGirl.create(:user) }
end

Then /^I should be able to see both hitchhikers$/ do
  User.all.each { |user| page.find("#user_#{user.id}").should have_content(user.to_s) }
end

When /^I change my location to "([^"]*)"$/ do |current_location|
  fill_in "Your current location", with: current_location
end

When /^I visit the profile page of "([^"]*)"$/ do |username|
  visit user_path(username)
end

When /^I visit the edit page of this trip$/ do
  visit edit_trip_path(Trip.last)
end

Given /^"([^"]*)" logged a trip$/ do |username|
  user = User.find_by_username username
  FactoryGirl.create(:trip, user_id: user.id)
end

When /^I click on the sign out link$/ do
  click_link "Sign Out"
end

Then /^I should be signed off$/ do
  expect(page).to_not have_content("Your Profile")
end

When(/^I login with facebook$/) do
  find('#facebook_login a').click
end

Then(/^I should be registered with facebook$/) do
  expect(User.where(uid: 10206267250652792)).not_to be_empty
end

Given /^a user with email same as his facebook account$/ do
  FactoryGirl.create(:user, email: 'florian@hitchlog.com')
end

Then /^the user should receive the data from facebook$/ do
  user = User.where(email: 'florian@hitchlog.com').first
  expect(user.date_of_birth).not_to be_nil
end
