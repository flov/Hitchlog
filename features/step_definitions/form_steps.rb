# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number                  | 5002       |
#     | Expiry date                     | 2009-11-01 |
#     | Note                            | Nice guy   |
#     | Wants Email?                    |            |
#     | Sex                  (select)   | Male       |
#     | Accept user agrement (checkbox) | check      |
#     | Send me letters      (checkbox) | uncheck    |
#     | radio 1              (radio)    | choose     |
#     | Avatar               (file)     | avatar.png |
#
When /^I fill in the following:$/ do |fields|

  select_tag    = /^(.+\S+)\s*(?:\(select\))$/
  check_box_tag = /^(.+\S+)\s*(?:\(checkbox\))$/
  radio_button  = /^(.+\S+)\s*(?:\(radio\))$/
  file_field    = /^(.+\S+)\s*(?:\(file\))$/

  fields.rows_hash.each do |name, value|
    case name
    when select_tag
      step %(I select "#{value}" from "#{$1}")
    when check_box_tag
      case value
      when 'check'
	step %(I check "#{$1}")
      when 'uncheck'
	step %(I uncheck "#{$1}")
      else
	raise 'checkbox values: check|uncheck!'
      end
    when radio_button
      step %{I choose "#{$1}"}
    when file_field
      step %{I attach the file "#{value}" to "#{$1}"}
    else
      step %{I fill in "#{name}" with "#{value}"}
    end
  end
end

When /^I press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^I fill in "([^"]*)" with:$/ do |field, value|
  fill_in(field, :with => value)
end

When /^I select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^I check "([^"]*)"$/ do |field|
  check(field)
end

When /^I uncheck "([^"]*)"$/ do |field|
  uncheck(field)
end

When /^I choose "([^"]*)"$/ do |field|
  choose(field)
end

When /^I attach the file "([^"]*)" to "([^"]*)"$/ do |file, field|
  path = File.expand_path(File.join(SUPPORT_DIR,"attachments/#{file}"))
  raise RuntimeError, "file '#{path}' does not exists" unless File.exists?(path)

  attach_file(field, path)
end

When /^I submit the form$/ do
  find('input[type="submit"]').click
end
