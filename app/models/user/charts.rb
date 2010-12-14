class User
  include ActionView::Helpers::TextHelper
  
  def chart_image
    "http://chart.apis.google.com/chart?cht=p
                                       &chs=650x200
                                       &chd=t:#{chart_numbers}
                                       &chds=0,#{chart_numbers_max}
                                       &chl=#{chart_label}
                                       &chtt=Hitchhiked Countries Of #{username.capitalize}
                                       &chts=676767,14".gsub(/\n( )+/,'')
  end

  def chart_numbers
    # [[2, 627, "Spain"], [3, 73, "The Netherlands"], [3, 129, "United States"], [3, 0, "unknown"], [3, 568, "United Kingdom"], [1, 232, "France"]] 
    chart_array.collect{|i| i.first}.join(",")
  end
  
  def chart_numbers_max
    chart_array.collect{|i| i.first}.max
  end
  
  def chart_label
    # [[2, 627, "Spain"], ...]
    chart_array.collect do |i| 
      if i[1] > 0
        "#{pluralize(i[0], 'ride')} - #{i[2]} (#{i[1]}km)"
      else
        "#{pluralize(i[0], 'ride')} #{i[2]}"
      end
    end.join("|")
  end
  
  def chart_array
    numbers = []
    trips.each do |trip| 
      if trip.from_country == trip.to_country
        numbers << [trip.hitchhikes.size, trip.distance/1000, trip.from_country] 
      else
        numbers << [trip.hitchhikes.size/2, trip.distance/1000/2, trip.from_country] 
        if trip.hitchhikes.size.odd?
          numbers << [(trip.hitchhikes.size/2)+1, trip.distance/1000/2, trip.to_country] 
        else
          numbers << [trip.hitchhikes.size/2, trip.distance/1000/2, trip.to_country] 
        end
      end
    end

    # if numbers looks like this:
    # [[2, 627, "Spain"], [1, 123, "China"], [2, 544, "Spain"]]
    # we need to check if there are two countries which are the same: 
    hash = {}
    numbers.each do |i|
      if hash.key?(i[2])
        hash[i[2]][0] += i[0]
        hash[i[2]][1] += i[1]
      else
        hash[i[2]] = [i[0],i[1]]
      end
    end
    # hash looks like this:
    # {"Spain"=>[4, 1171], "China"=>[1, 123]} 
    numbers = []
    hash.each do |k,v|
      numbers << (v << k)
    end
    
    numbers
  end
end