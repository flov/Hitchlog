Then /^I should be on the (.+?) page$/ do |page_name|
  request.request_uri.should == send("#{page_name.downcase.gsub(' ','_')}_path")
  response.should be_success
end

Then /^I should be redirected to the (.+?) page$/ do |page_name|
  request.headers['HTTP_REFERER'].should_not be_nil
  request.headers['HTTP_REFERER'].should_not == request.request_uri

  Then "I should be on the #{page_name} page"
end