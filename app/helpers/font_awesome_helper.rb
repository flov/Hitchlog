module FontAwesomeHelper
  def male(title = '')
    "<i class='fa fa-male blue tip' title='#{title}'></i>".html_safe
  end

  def female(title = '')
    "<i class='fa fa-female pink tip' title='#{title}'></i>".html_safe
  end

  def hitchhiker_gender(gender)
    if gender == 'male'
      male(t('helper.male_hitchhiker'))
    elsif gender == 'female'
      female(t('helper.female_hitchhiker'))
    end
  end

  def passenger_gender(gender)
    if gender == 'male'
      male(t('helper.male_people'))
    elsif gender == 'female'
      female(t('helper.male_people'))
    elsif gender == 'mixed'
      "<span class='tip' title='#{t('helper.mixed_people')}'>
        #{male}
        #{female}
      </span>".html_safe
    end
  end

  def country(country, country_distance=nil)
    country_code = Countries[country]

    if country_distance
      title = "#{country} #{distance( country_distance )}"
    else
      title = country
    end

    flag(country_code, title)
  end

  def country_images_for_user(user)
    array = []; hash = {}
    user.trips.map(&:country_distances).flatten.each do |cd|
      if hash[cd.country]
        hash[cd.country] += cd.distance
      else
        hash[cd.country] =  cd.distance
      end
    end

    hash.each do |country, distance|
      array << country(country, distance)
    end

    array.join(' ').html_safe
  end

  def countries_for_trip(trip)
    array = []
    trip.country_distances.each do |country_distance|
      array << country(country_distance.country, country_distance.distance)
    end
    array.join(' ').html_safe
  end

  def all_country_images
    array = []
    country_distances = CountryDistance.pluck(:country).uniq
    country_distances -= ['unknown', '']
    country_distances.each do |country|
      array << link_to(country(country), "trips/?q%5Bcountry_distances_country_eq%5D=#{country}")
    end
    array.join(' ').html_safe
  end

  def flag(country_code, title = nil)
    country_code = Countries[country_code] if country_code and country_code.length != 2
    return if country_code.blank?
    title = Countries[country_code] if title.nil?
    "<div class='flags-#{country_code.downcase} tip' title='#{title}'></div>".html_safe
  end

  def flag_with_country_name(user)
    return user.location if user.country_code.blank? and user.city.blank?
    return user.city     if user.country_code.blank?
    "#{flag(user.country_code)} <a href='http://maps.google.com.au/?q=#{user.country}+#{user.city}'>#{user.country}, #{user.city}</a>".html_safe
  end

  def waiting_time(time=nil)
    if time.nil?
      "<i class='fa fa-time'></i>".html_safe
    else
      "<i class='fa fa-time tip' title='#{t('helper.waiting_time', time: time)}'></i>".html_safe
    end
  end

  def tags(tag_list)
    tag_list.map{|tag| link_to h(tag), trips_path("q[rides_tags_name_eq]" => tag), class: 'tag'}.join(' ').html_safe
  end

  def very_positive(title = t('helper.extremely_positive_experience'))
    "<span class='tip very-positive' title='#{title}'>
      <i class='fa fa-heart'></i>
    </span>".html_safe
  end
  def positive(title = t('helper.positive_experience'))
    "<i class='fa fa-smile tip' title='#{title}'></i>".html_safe
  end
  def neutral(title = t('helper.neutral_experience'))
    "<i class='fa fa-meh tip' title='#{title}'></i>".html_safe
  end
  def negative(title = t('helper.negative_experience'))
    "<i class='fa fa-frown tip' title='#{title}'></i>".html_safe
  end
  def very_negative(title = t('helper.extremely_negative_experience'))
    "<span class='tip' title='#{title}'>
      <i class='fa fa-bolt'></i>
    </span>".html_safe
  end

  def experience(exp)
    if exp == 'positive'
      positive
    elsif exp == 'extremely positive'
      very_positive
    elsif exp == 'neutral'
      neutral
    elsif exp == 'negative'
      negative
    elsif exp == 'extremely negative'
      very_negative
    end
  end

  def driving_time(time)
    "<i class='fa fa-road tip' title='#{t('helper.driving_time', time: time)}'></i>".html_safe if time
  end

  def photo
    "<i class='fa fa-picture tip' title='#{t('helper.photo')}'></i>".html_safe
  end

  def number_of_rides(size)
    "<span class='tip' title='#{pluralize(size, t('general.ride'))}'>
      #{size}
      <i class='fa fa-thumbs-up tip'></i>
    </span>".html_safe
  end

  def number_of_comments(size)
    "<span class='tip' title='#{pluralize(size, t('general.comment'))}'>
      #{size}
      <i class='fa fa-comment tip'></i>
    </span>".html_safe
  end

  def number_of_photos(size)
    "<span class='tip' title='#{pluralize(size, t('general.photo'))}'>
      #{size}
      <i class='fa fa-picture tip'></i>
    </span>".html_safe
  end

  def icons_for_trip(trip)
    icons = [ ]
    icons << experience(trip.overall_experience)
    icons << number_of_rides(trip.rides.size)
    icons << number_of_comments(trip.comments.size) if trip.comments.size > 0
    icons << number_of_photos(trip.rides.with_photo.size) if trip.rides.with_photo.size > 0
    trip.country_distances.map(&:country).each do |country|
      icons << flag(country)
    end
    icons << hitchhiking_with_image(trip.travelling_with)
    icons << waiting_time( trip.total_waiting_time ) if trip.total_waiting_time
    icons << driving_time( trip.total_driving_time ) if trip.total_driving_time

    icons.join(' ').html_safe
  end
end
