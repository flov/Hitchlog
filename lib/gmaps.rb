module Gmaps
  def Gmaps::distance(from='', to='',via='')
    # Possible Values for result['status] 
    # "OK" indicates that no errors occurred; the address was successfully parsed and at least one geocode was returned.
    # "ZERO_RESULTS" indicates that the geocode was successful but returned no results. This may occur if the geocode was passed a non-existent address or a latlng in a remote location.
    # "OVER_QUERY_LIMIT" indicates that you are over your quota.
    # "REQUEST_DENIED" indicates that your request was denied, generally because of lack of a sensor parameter.
    # "INVALID_REQUEST" generally indicates that the query (address or latlng) is missing.
    # "OFFLINE" indicates that you are not online
    url = "http://maps.googleapis.com/maps/api/directions/json?origin=#{CGI::escape(from)}&destination=#{CGI::escape(to)}&sensor=false"
    #url = "http://maps.googleapis.com/maps/api/directions/json?origin=Amsterdam&waypoints=Antwerpen|Lille&destination=Duisburg&sensor=false"
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
      result['results'][0]['formatted_address']
    else
      "unknown"
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

    if result['status'] == "OK"
      country = ''
      result['results'][0]['address_components'].each{|address| country = address['long_name'] if address['types'].include?("country")}
      country
    else
      "unknown"
    end
  end
  
  def Gmaps::countries(from, to)
    url = "http://maps.googleapis.com/maps/api/directions/json?origin=#{CGI::escape(from)}&destination=#{CGI::escape(to)}&sensor=false"
    begin
      data = Net::HTTP.get_response(URI.parse(url)).body
      # we convert the returned JSON data to native Ruby hash
      result = JSON.parse(data)
    rescue Exception => e
      # Should only happen when used offline. Should not happen if online
      result = {'status' => 'OFFLINE'}
    end
    if result['status'] == 'OK' # compute distance
      countries = [[Gmaps.country(from), nil]]
      distance = 0
      result['routes'][0]['legs'][0]['steps'].each_with_index do |step, i|
        distance += step['distance']['value']
        if step['html_instructions'].match(/Entering [A-Z]/)
          nokogiri = Nokogiri::HTML(step['html_instructions'])
          country = nokogiri.search('div').last.content.sub('Entering ','')
          countries[-1][1] = distance
          countries << [country, nil]
          distance = 0
        end
        if i == result['routes'][0]['legs'][0]['steps'].size-1
          countries[-1][1] = distance
        end
      end 
      countries
    else
      result['status']
    end
  end

  def Gmaps::city(address)
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{CGI::escape(address)}&sensor=false"
    begin
      data = Net::HTTP.get_response(URI.parse(url)).body
      result = JSON.parse(data)
    rescue Exception => e
      # Should only happen when used offline. Should not happen if online
      result = {'status' => 'OFFLINE'}
    end
    if result['status'] == "OK"
      country = ''
      result['results'][0]['address_components'].each do |address|
        country = address['long_name'] if address['types'].include?("locality") and address['types'].include?("political")
        break unless country.blank?
      end
      country
    else
      address
    end
  end
end
