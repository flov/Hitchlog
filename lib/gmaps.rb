module Gmaps
  def Gmaps::distance(from, to)
     url = "http://maps.googleapis.com/maps/api/directions/json?origin=#{from}&destination=#{to}&sensor=false"
     resp = Net::HTTP.get_response(URI.parse(url))
     data = resp.body

     # we convert the returned JSON data to native Ruby
     # data structure - a hash
     result = JSON.parse(data)

     distance = 0
     unless result['status'] == 'NOT_FOUND'
       #  we take the first route and iterate over the legs to compute the total distance
       result['routes'][0]['legs'].each{|leg| distance += leg['distance']['value']} 
     end
     distance
  end
end