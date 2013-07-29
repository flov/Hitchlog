When /^I type in "([^"]*)" as a tag$/ do |tag|
  fill_in('ride_tag_list', with: tag)
end

Then /^I should see "([^"]*)" as a tag on the trip$/ do |tag|
  within ".entry-meta" do
    page.should have_content(tag)
  end
end

