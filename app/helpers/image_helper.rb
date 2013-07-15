module ImageHelper
  def images_for_ride(ride)
    [
      hitchhiking_with_image(ride.trip.travelling_with),
      country_images_for_trip(ride.trip),
      experience_image(ride.experience),
      gender_people_image(ride.gender),
      waiting_time_image(human_minutes(ride.waiting_time)),
      driving_time_image(human_hours(ride.duration)),
      ride_has_story_image(ride)
    ].join(' ').html_safe
  end

  def images_for_trip(trip)
    images = [
      hitchhiking_with_image(trip.travelling_with) 
    ]
    trip.rides.each do |ride|
      images << waiting_time_image(human_minutes(ride.waiting_time)) if ride.waiting_time
      images << driving_time_image(human_hours(ride.duration)) if ride.duration
      images << photo_image if ride.photo_file_name
    end
    images.join(' ').html_safe
  end

  def hitchhiking_with_text(number)
    unless number.nil?
      case number
      when 0
        t('helper.trip.alone')
      when 1
        t('helper.trip.with_1')
      when 2
        t('helper.trip.with_2')
      when 3
        t('helper.trip.with_3')
      when 4
        t('helper.trip.with_4')
      when 5
        t('helper.trip.with_more_than_4')
      else
        more_than_three_people_image
      end
    end
  end

  def hitchhiking_with_image(number)
    unless number.nil?
      case number
      when 0
        alone_image
      when 1
        two_people_image
      when 2
        three_people_image
      else
        more_than_three_people_image
      end
    end
  end

  def country_images_for_user(user)
    array = []; hash = {}
    user.trips.map{|x| x.country_distances}.flatten.each do |cd|
      if hash[cd.country]
        hash[cd.country] += cd.distance 
      else
        hash[cd.country] =  cd.distance 
      end
    end

    hash.each do |country, distance|
      array << country_image(country, distance)
    end

    array.join(' ').html_safe
  end

  def country_images_for_trip(trip)
    array = []
    trip.countries_with_distance.each do |hash|
      array << country_image(hash[:country], hash[:distance])
    end
    array.join(' ').html_safe
  end

  def all_country_images
    array = []
    countries = CountryDistance.pluck(:country).uniq
    countries -= ['unknown', 'The Netherlands', 'Kingdom of Sweden', '']
    countries.each do |country|
      array << link_to(country_image(country), "trips/?country=#{country}")
    end
    array.join(' ').html_safe
  end

  def about_person_image
    image_tag("icons/user_comment.png", class: 'tip', title: t('helper.about_person_image'))
  end

  def alone_image
    image_tag("icons/alone.png", :class => 'tip', title: t('helper.one_person_hitchhike'))
  end

  def two_people_image
    image_tag("icons/two_people.png", :class => 'tip', :title => t('helper.two_people_hitchhike'))
  end

  def three_people_image
    image_tag("icons/three_people.png", :class => 'tip', :title => t('helper.three_people_hitchhike'))
  end

  def more_than_three_people_image  
    image_tag("icons/more_than_three_people.png", :class => 'tip', :title => t('helper.more_than_three_people_hitchhike'))
  end
  
 def add_information_image
    image_tag("icons/add.png", :class => 'tip', :title => t('helper.add_information_to_hitchhike'))
  end

  def female_image(i18n = 'helper.female')
    image_tag("icons/female.png", :class => 'tip', :title => t(i18n), width: 16, height: 16)
  end

  def male_image(i18n = 'helper.male_people')
    image_tag("icons/male.png", :class => 'tip', :title => t(i18n), width: 16, height: 16)
  end

  def gender_image(gender)
    if gender == 'male'
      male_image
    elsif gender == 'female'
      female_image
    end
  end

  def gender_hitchhiker_image(gender)
    if gender == 'male'
      male_image('helper.male_hitchhiker')
    elsif gender == 'female'
      female_image('helper.female_hitchhiker')
    end
  end

  def gender_people_image(gender)
    if gender == 'male'
      image_tag("icons/male.png", :class => 'tip', :title => t('helper.male_people'))
    elsif gender == 'female'
      image_tag("icons/female.png", :class => 'tip', :title => t('helper.female_people'))
    elsif gender == 'mixed'
      image_tag("icons/mixed_gender.png", :class => 'tip', :title => t('helper.mixed_people'))
    end
  end

  def experience_image(exp)
    if exp == 'positive'
      image_tag("icons/positive.png", :class => 'tip', :title => t('helper.positive_experience'), width: 16, height: 16)
    elsif exp == 'extremely positive'
      image_tag("icons/extremely_positive.png", :class => 'tip', :title => t('helper.extremely_positive_experience'), width: 16, height: 16)
    elsif exp == 'neutral'
      image_tag("icons/neutral.png", :class => 'tip', :title => t('helper.neutral_experience'), width: 16, height: 16)
    elsif exp == 'negative'
      image_tag("icons/negative.png", :class => 'tip', :title => t('helper.negative_experience'), width: 16, height: 16)
    elsif exp == 'extremely negative'
      image_tag("icons/extremely_negative.png", :class => 'tip', :title => t('helper.extremely_negative_experience'), width: 16, height: 16)
    end
  end

  def overall_experience_image(exp)
    if exp == 'positive'
      image_tag("icons/positive.png", :class => 'tip', :title => t('helper.overall_positive_experience'), width: 16, height: 16)
    elsif exp == 'extremely positive'
      image_tag("icons/extremely_positive.png", :class => 'tip', :title => t('helper.overall_extremely_positive_experience'), width: 16, height: 16)
    elsif exp == 'neutral'
      image_tag("icons/neutral.png", :class => 'tip', :title => t('helper.overall_neutral_experience'), width: 16, height: 16)
    elsif exp == 'negative'
      image_tag("icons/negative.png", :class => 'tip', :title => t('helper.overall_negative_experience'), width: 16, height: 16)
    elsif exp == 'extremely negative'
      image_tag("icons/extremely_negative.png", :class => 'tip', :title => t('helper.overall_extremely_negative_experience'), width: 16, height: 16)
    end
  end

  def delete_ride_image
    image_tag("icons/cross.png", :class => 'tip', :title => t('helper.delete_hitchhike'))
  end

  def delete_trip_image
    image_tag("icons/cross.png", :class => 'tip', :title => t('helper.delete_trip'))
  end

  def user_image
    image_tag("icons/user.png", :class => 'tip')
  end

  def waiting_time_image(time=nil)
    if time.nil?
      image_tag("icons/time.png")
    else
      image_tag("icons/time.png", :class => 'tip', :title => t('helper.waiting_time', :time => time))
    end
  end

  def waiting_time_missing_image
    image_tag("icons/time_delete.png", :class => 'tip', :title => t('helper.waiting_time_missing'))
  end

  def ride_image(number)
    image_tag("icons/car.png", :class => 'tip', :title => t('helper.rides', :count => number))
  end

  def driving_time_missing_image
    image_tag("icons/car_delete.png", :class => 'tip', :title => t('helper.driving_time_missing'))
  end

  def photo_missing_image
    image_tag("icons/photo_delete.png", :class => 'tip', :title => t('helper.photo_missing'))
  end

  def photo_image
    image_tag("icons/photo.png", :class => 'tip', :title => t('helper.photo'))
  end

  def photo_image_button
    image_tag("icons/photo.png")
  end

  def ride_has_story_image(ride)
    image_tag("icons/story.png", :class => 'tip', title: t('helper.ride_has_story')) unless ride.story.blank?
  end

  def story_image
    image_tag("icons/story.png", :class => 'tip')
  end

  def add_story_image
    image_tag("icons/story.png", :class => 'tip', :title => t('helper.add_story_image'))
  end

  def story_missing_image
    image_tag("icons/script_delete.png", :class => 'tip', :title => t('helper.story_missing'))
  end

  def add_image
    image_tag('icons/add.png', :class => 'tip', :title => t('helper.add_information'))
  end

  def facebook_page
    link_to "Find Hitchlog On Facebook", 'https://www.facebook.com/profile.php?id=740638119', :id => 'facebook_button'
  end

  def twitter_account
    link_to "Find Hitchlog On Twitter", 'http://twitter.com/#!/hitchlog', :id => 'twitter_button'
  end

  def gmaps_duration_image(trip)
    image_tag("icons/google.png", :class => 'tip', :title => t('helper.gmaps_duration', :duration => human_seconds(trip.gmaps_duration))) if trip.gmaps_duration
  end

  def trip_duration_image(trip)
    image_tag("icons/car_red.png", :class => 'tip', :title => t('helper.trip_duration', :duration => human_seconds(trip.duration)))
  end

  def driving_time_image(time)
    if time
      image_tag("icons/car.png", :class => 'tip', :title => t('helper.driving_time', :time => time))
    end
  end

  def flag(country_code)
    unless country_code.nil?
      image_tag "flags/png/#{country_code.downcase}.png",
        class: 'tip',
        title: "#{I18nData.countries["#{country_code}"]}"
    end
  end

  def flag_with_country_name(user)
    if user.country_code.blank? and user.city.blank?
      user.location
    elsif user.country_code.blank?
      user.city
    else
      "#{flag(user.country_code)} <a href='http://maps.google.com.au/?q=#{user.country}+#{user.city}'>#{user.country}, #{user.city}</a>".html_safe
    end
  end

  def country_image(country, country_distance=nil)
    case country
      when "The Netherlands" then country = "Netherlands"
      when "Macedonia (FYROM)" then country = "Macedonia"
      when "Kingdom of Sweden" then country = "Sweden"
      # Add more exceptions...
    end

    unless I18nData.country_code(country).nil?
      if country_distance == nil
        image_tag "flags/png/#{I18nData.country_code(country).downcase}.png", class: 'tip', title: "#{country}"
      else
        image_tag "flags/png/#{I18nData.country_code(country).downcase}.png", class: 'tip', title: "#{country} #{distance( country_distance )}"
      end
    end
  end
end
