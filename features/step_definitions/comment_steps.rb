When /^I fill in a comment with "([^"]*)"$/ do |comment|
  fill_in "body", :with => comment
end

Then /^I should see Wow! in the comments dialog$/ do
  expect(page.find("#view-comments")).to have_content('Wow!')
end
