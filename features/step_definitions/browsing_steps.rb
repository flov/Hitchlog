When /^I go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^I should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  current_path.should == path_to(page_name)
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end
