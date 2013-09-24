When /^I go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^I should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  current_path.should == path_to(page_name)
end

Then /^I should(\ not)? see "([^"]*)"$/ do |negative, text|
  if negative
    page.should_not have_content(text)
  else
    page.should have_content(text)
  end
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^I click on "([^"]*)"$/ do |link|
  click_link(link)
end
