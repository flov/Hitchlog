module Gmaps
  def Gmaps::distance(from, to)
    # Possible Values for result['status] 
    # "OK" indicates that no errors occurred; the address was successfully parsed and at least one geocode was returned.
    # "ZERO_RESULTS" indicates that the geocode was successful but returned no results. This may occur if the geocode was passed a non-existent address or a latlng in a remote location.
    # "OVER_QUERY_LIMIT" indicates that you are over your quota.
    # "REQUEST_DENIED" indicates that your request was denied, generally because of lack of a sensor parameter.
    # "INVALID_REQUEST" generally indicates that the query (address or latlng) is missing.
    # "OFFLINE" indicates that you are not online
    url = "http://maps.googleapis.com/maps/api/directions/json?origin=#{CGI::escape(from)}&destination=#{CGI::escape(to)}&sensor=false"
    begin
      data = Net::HTTP.get_response(URI.parse(url)).body
      # we convert the returned JSON data to native Ruby hash
      result = JSON.parse(data)
    rescue Exception => e
      # Should only happen when used offline. Should not happen if online
      result = {'status' => 'OFFLINE'}
    end
    distance = 0
    if result['status'] == 'OK' # compute distance
      result['routes'][0]['legs'].each{|leg| distance += leg['distance']['value']} 
    elsif result['status'] == 'OFFLINE'
      distance = -1
    elsif result['status'] == 'OVER_QUERY_LIMIT'
      distance = -2
    elsif result['status'] == 'REQUEST_DENIED'
      distance = -3
    elsif result['status'] == 'INVALID_REQUEST'
      distance = -4
    elsif result['status'] == 'ZERO_RESULTS'
      distance = -5
    end
    distance
  end
  
  def Gmaps::formatted_address(address)
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{CGI::escape(address)}&sensor=false"
    begin
      data = Net::HTTP.get_response(URI.parse(url)).body
      result = JSON.parse(data)
    rescue Exception => e
      # Should only happen when used offline. Should not happen if online
      result = {'status' => 'OFFLINE'}
    end

    if result['status'] == "OK"
      result['results'].first['formatted_address']
    else
      "unkown"
    end
  end
  
  def Gmaps::country(address)
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{CGI::escape(address)}&sensor=false"
    begin
      data = Net::HTTP.get_response(URI.parse(url)).body
      result = JSON.parse(data)
    rescue Exception => e
      # Should only happen when used offline. Should not happen if online
      result = {'status' => 'OFFLINE'}
    end
    country = 'unknown'
    if result['status'] == "OK"
      result['results'].first['address_components'].each{|address| country = address['long_name'] if address['types'].include?("country")}    
    end
    country
  end
end
