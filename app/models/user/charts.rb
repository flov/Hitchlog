class User
  def to_chart_image
    "http://chart.apis.google.com/chart?chs=400x218&cht=p&chd=s:FBCH&chdl=#{to_trip_countries}&chp=2.233&chl=#{to_trip_rides}&chma=43|0,2"
    "http://chart.apis.google.com/chart?chs=400x218&cht=p&chd=s:FBCH&chdl=Germany|United+Kingdom&chp=2.233&chl=290km|599km&chma=43|0,2"
    http://chart.apis.google.com/chart
       ?chs=313x218
       &cht=p
       &chd=s:FB
       &chdl=Germany|United+Kingdom
       &chl=290km|599km
       &chma=43|0,2
  end

  private
  
  def to_trip_countries
    countries = trips.collect{|trip| [trip.to_country, trip.from_country]}.flatten
    @country_hash = {}
    countries.each do |country|
      if @country_hash[country].nil?
        @country_hash[country] = 1
      else
        @country_hash[country] += 1
      end
    end
    @coutry_hash
  end
  
  def to_trip_rides
    array = []
    @country_hash.each_key do |key|
      array << key
    end
    array.join '|'
  end
  
  def to_number_of_hitchhikes_in_countries
    array = []
    @country_hash.each_value do |value|
      array << "#{value} rides"
    end
    array.join '|'
  end
end