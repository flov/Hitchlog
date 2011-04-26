module Chart
  include ActionView::Helpers::TextHelper
  
  def chart_image(trips, user=nil, options={})
    array = chart_array(trips)
    if user.nil? 
      title = 'Hitchhiked Countries Of The Hitchlog' 
    else
      title = "Hitchhiked Countries Of #{user}"
    end

    if options[:size] == 'small'
      options[:resolution] = '340x100'
      chart_label = small_chart_label(array)
      title = nil
    elsif options[:size] == 'tiny'
      options[:resolution] = '200x100'
      chart_label = tiny_chart_label(array)
    else
      chart_label          ||= chart_label(array)
      options[:resolution] ||= '540x200'
    end


    image = "http://chart.apis.google.com/chart?cht=p
                                       &chs=#{options[:resolution]}
                                       &chd=t:#{chart_numbers(array)}
                                       &chds=0,#{chart_numbers_max(array)}
                                       &chl=#{chart_label}
                                       &chtt=#{title}
                                       &chts=676767,14".gsub(/\n( )+/,'')
    image << '&cht=p3'                      if options[:three_dimensional] == true
    image << "&chf=bg,s,#{options[:color]}" if options[:color]
    image
  end

  protected

  def chart_numbers(chart_array)
    # [[2, 627, "Spain"], [3, 73, "The Netherlands"], [3, 129, "United States"], [3, 0, "unknown"], [3, 568, "United Kingdom"], [1, 232, "France"]] 
    chart_array.collect{|i| i[1]}.join(",")
  end
  
  def chart_numbers_max(chart_array)
    chart_array.collect{|i| i[1]}.max
  end
  
  def chart_label(chart_array)
    # [[2, 627, "Spain"], ...]
    chart_array.collect do |i| 
      "#{i[2]} #{i[1]}km"
    end.join("|")
  end

  def tiny_chart_label(chart_array)
    # [[2, 627, "Spain"], ...]
    chart_array.collect{|i| i[2]}.join("|")
  end

  def small_chart_label(chart_array)
    # [[2, 627, "Spain"], ...]
    chart_array.collect do |i| 
      "#{i[2]} #{i[1]}km"
    end.join("|")
  end
  
  def chart_array(trips)
    numbers = []
    trips.each do |trip| 
      trip.country_distances.each do |country_distance|
        numbers << [trip.hitchhikes.size, country_distance.distance/1000, country_distance.country]
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
