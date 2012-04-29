Then /^a mail should have been delivered to "([^"]*)"$/ do |user|
  ActionMailer::Base.deliveries.should_not be_empty
end

Then /^a mail should have been delivered$/ do
  ActionMailer::Base.deliveries.should_not be_empty
end

