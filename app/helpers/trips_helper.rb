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

  def options_for_experiences
    array =[]
    Ride::EXPERIENCES.each do |experience|
      array << "<option value='#{experience}'>#{t("general.#{experience.parameterize('_')}")}</option>"
    end
    array.join ''
  end

  def options_for_countries
    countries = CountryDistance.pluck(:country).uniq.sort
    array =[]
    countries.each{|country| array << "<option>#{country}</option>"}
    array.join ''
  end

  def truncated_markdown(string, length = 200)
    if string.class == String
      RDiscount.new(
        truncate(string, length: length,
                         separator: ' ',
                         omission: "... #{t('trips.list.read_on')}"),
       :smart,
       :filter_html
      ).to_html.html_safe
    end
  end

  def distance_of_time_helper
    "
     <span class='tip', title='#{t('general.trip_duration')}'>\
       <i class='fa fa-time'></i> <span id='distance_of_time'>8h</span>\
     </span>\
     &nbsp; &nbsp;
     <span class='tip', title='#{t('general.google_maps_duration')}'>\
       <b>G</b> <span id='google_maps_duration'>0h</span>\
     </span>\
     &nbsp; &nbsp;
     <span class='tip', title='#{t('general.hitchhiked_kms')}'>\
       <i class='fa fa-dashboard'></i> <span id='trip_distance_display'>0 kms</span>\
     </span>\
    ".html_safe
  end

  def embed_youtube_video(youtube_id)
    "<div class='youtube_iframe_container'>
      <iframe width='560' height='315'
        src='https://www.youtube.com/embed/#{youtube_id}' frameborder='0'
        allow='accelerometer; autoplay; encrypted-media; gyroscope;
        picture-in-picture' allowfullscreen></iframe>
    </div>".html_safe
  end
end
