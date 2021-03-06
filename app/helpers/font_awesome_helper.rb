module FontAwesomeHelper
  def icon(name, options = {})
    "<i class='fa fa-#{name} #{options[:class]}' title='#{options[:title]}'></i>".html_safe
  end

  def male(title = '')
    icon('male', class: 'blue tip', title: title)
  end

  def female(title = '')
    icon('female', class: 'pink tip', title: title)
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
      icon('time')
    else
      icon('time', class: 'tip', title: t('helper.waiting_time', time: time))
    end
  end

  def tags(tag_list)
    tag_list.map{|tag| link_to h(tag.name), trips_path("q[rides_tags_name_eq]" => tag.name), class: 'tag'}.join(' ').html_safe
  end

  def very_good(title = t('helper.very_good_experience'))
    "<span class='tip very-good' title='#{title}'>
      #{icon('heart')}
      #{icon('smile-o')}
    </span>".html_safe
  end
  def good(title = t('helper.good_experience'))
    icon('smile-o', class: 'tip', title: title)
  end
  def neutral(title = t('helper.neutral_experience'))
    icon('meh-o', class: 'tip', title: title)
  end
  def bad(title = t('helper.bad_experience'))
    icon('frown-o', class: 'tip', title: title)
  end
  def very_bad(title = t('helper.very_bad_experience'))
    "<span class='tip' title='#{title}'>
      #{icon('bolt')}
      #{icon('frown-o')}
    </span>".html_safe
  end

  def experience(exp)
    if exp == 'good'
      good
    elsif exp == 'very good'
      very_good
    elsif exp == 'neutral'
      neutral
    elsif exp == 'bad'
      bad
    elsif exp == 'very bad'
      very_bad
    end
  end

  def video
    icon('video-camera', class: 'tip', title: t('helper.video'))
  end

  def driving_time(time)
    if time
      icon('road', class: 'tip', title: t('helper.driving_time', time: time))
    end
  end

  def photo
    icon('picture-p', class: 'tip', title: t('helper.photo'))
  end

  def number_of_rides(size)
    "<span class='tip' title='#{pluralize(size, t('general.ride'))}'>
      #{size}
      #{icon('thumbs-up')}
    </span>".html_safe
  end

  def number_of_comments(size)
    "<span class='tip' title='#{pluralize(size, t('general.comment'))}'>
      #{size}
      #{icon('comment-o')}
    </span>".html_safe
  end

  def number_of_photos(size)
    "<span class='tip' title='#{pluralize(size, t('general.photo'))}'>
      #{size}
      #{icon('picture-o')}
    </span>".html_safe
  end

  def icons_for_trip(trip)
    good
    icons = [ ]
    icons << experience(trip.overall_experience)
    icons << type_of_rides(trip.rides.pluck(:vehicle))
    icons << number_of_rides(trip.rides.size)
    icons << video if trip.rides.with_video.size > 0
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

  def type_of_rides(vehicles)
    vehicles.reject! {|x| x.blank?}
    vehicles.map do |vehicle|
      type_of_ride(vehicle)
    end
  end

  def type_of_ride(vehicle)
    icon(vehicle, class: 'tip', title: t('general.got_a_ride_with', vehicle: t("rides.vehicles.#{vehicle}")))
  end
end
