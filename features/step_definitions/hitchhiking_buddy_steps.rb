Then /^I should see that "([^"]*)" is searching for a hitchhiking buddy from "([^"]*)" to "([^"]*)"$/ do |username, from, to|
  within(".future_trips") do
    expect(page).to have_content( username )
    expect(page).to have_content( from )
    expect(page).to have_content( to )
  end
end
