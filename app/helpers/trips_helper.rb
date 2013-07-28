module TripsHelper
  def log_trip_header(trip)
    if trip.new_record?
      "<h3>Log a new Hitchhiking Trip</h3>".html_safe
    else
      "<h3>Edit Hitchhiking Trip</h3>".html_safe
    end
  end

  def hitchhiked_with(number)
    unless number.nil?
      case number
      when 0
        I18n.t('helper.trip.alone')
      when 1
        I18n.t('helper.trip.with_1')
      when 2
        I18n.t('helper.trip.with_2')
      when 3
        I18n.t('helper.trip.with_3')
      when 4
        I18n.t('helper.trip.with_4')
      else
        I18n.t('helper.trip.with_more_than_4')
      end
    end
  end

  def trip_has_duration(trip)
    (!trip.duration.nil? and trip.duration > 0) or (trip.departure.nil? and trip.departure.nil?)
  end  

  def ride_box_attributes(i, trip)
    array=[]
    array << "ride"
    array << "last" if i == trip.rides.size
    array.join ' '
  end

  def options_for_gender
    "<option>#{t('helper.male_hitchhiker')}</option><option>#{t('helper.female_hitchhiker')}</option>"
  end

  def experiences
    [
      t('general.extremely_positive'),
      t('general.positive'),
      t('general.neutral'),
      t('general.negative'),
      t('general.extremely_negative')
    ]
  end

  def options_for_experiences
    array =[]
    experiences.each{|experience| array << "<option>#{experience}</option>"}
    array.join ''
  end

  def options_for_countries
    countries = CountryDistance.all.map(&:country).uniq.sort
    array =[]
    countries.each{|country| array << "<option>#{country}</option>"}
    array.join ''
  end

  def truncated_markdown(string)
    RDiscount.new(truncate(string, :length => 200, :separator => ' ', :omission => "... #{t('trips.list.read_on')}")).to_html.html_safe if string.class == String
  end

  def distance_of_time_helper
    "
     <span class='tip', title='#{t('general.trip_duration')}'>\
       <i class='icon-time'></i> <span id='distance_of_time'>8h</span>\
     </span>\
     &nbsp; &nbsp;
     <span class='tip', title='#{t('general.google_maps_duration')}'>\
       <b>G</b> <span id='google_maps_duration'>0h</span>\
     </span>\
     &nbsp; &nbsp;
     <span class='tip', title='#{t('general.hitchhiked_kms')}'>\
       <i class='icon-dashboard'></i> <span id='trip_distance_display'>0 kms</span>\
     </span>\
    ".html_safe
  end

  def icon_helper_for_new_trip
  end
end
