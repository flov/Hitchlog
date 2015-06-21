Then /^I should see that "([^"]*)" is searching for a hitchhiking buddy from "([^"]*)" to "([^"]*)"$/ do |username, from, to|
  within(".future_trips") do
    page.should have_content( username )
    page.should have_content( from )
    page.should have_content( to )
  end
end
