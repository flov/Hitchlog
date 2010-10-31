Then /^the distance between "([^"]*)" and "([^"]*)" should be saved$/ do |origin, destination|
  Gmaps.distance(origin, destination)
end