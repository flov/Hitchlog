When /^I fill in the future trip form with from "([^"]*)" to "([^"]*)" at the "([^"]*)"$/ do |arg1, arg2, arg3|
  fill_in :from, with: "Barcelona"
  fill_in :to, with: "Madrid"
  fill_in :departure, with: "21 December 2012"
end

Then /^I should see the future trip from "([^"]*)" to "([^"]*)" at the "([^"]*)"$/ do |from, to, departure|
  page.should have_content(departure)
  page.should have_content(from)
  page.should have_content(to)
end

When /^I follow the edit future trip link$/ do
  find("#future_trips").click("Edit")
end

When /^I click on delete future trip$/ do
  find("#future_trips").click("Delete")
end

