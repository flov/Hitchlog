Then /^a mail should have been delivered to "([^"]*)"$/ do |user|
  ActionMailer::Base.deliveries.should_not be_empty
end

Then /^a mail should have been delivered$/ do
  ActionMailer::Base.deliveries.should_not be_empty
end

Then /^(\d)+ emails? should be delivered to the trip owner$/ do |count|
  puts emails
  emails("to: \"#{@trip.user.email}\"").size.should == count.to_i
end

Then(/^show me the emails?$/) do
   save_and_open_emails
end
