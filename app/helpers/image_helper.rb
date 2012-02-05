module ImageHelper
  def images_missing_for_ride(ride)
    array = []
    array << waiting_time_missing_image unless ride.waiting_time
    array << driving_time_missing_image unless ride.duration
    link_to array.join(' ').html_safe, edit_trip_path(ride.trip)
  end

  def images_for_ride(ride)
    array = []
    array << gender_people_image(ride.gender) if ride.gender
    array << waiting_time_image(human_minutes(ride.waiting_time)) if ride.waiting_time
    array << driving_time_image(human_hours(ride.duration)) if ride.duration
    array << photo_image if ride.photo.file?
    string = array.join(' ')
    string.html_safe 
  end

  def images_for_trip(trip)
    images = []
    trip.rides.each do |ride|
      images << gender_people_image(ride.gender) if ride.gender
      images << waiting_time_image(human_minutes(ride.waiting_time)) if ride.waiting_time
      images << driving_time_image(human_hours(ride.duration)) if ride.duration
      images << photo_image if ride.photo.file?
    end
    string = images.join(' ')
    string.html_safe 
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

  def about_person_image
    image_tag("icons/user_comment.png", :class => 'tooltip', :alt => t('helper.about_person_image'))
  end

  def alone_image
    image_tag("icons/alone.png", :class => 'tooltip', :alt => t('helper.alone'))
  end

  def two_people_image
    image_tag("icons/two_people.png", :class => 'tooltip', :alt => t('helper.two'))
  end

  def three_people_image
    image_tag("icons/three_people.png", :class => 'tooltip', :alt => t('helper.three'))
  end

  def more_than_three_people_image  
    image_tag("icons/more_than_three_people.png", :class => 'tooltip', :alt => t('helper.more_than_three'))
  end
  
 def add_information_image
    image_tag("icons/add.png", :class => 'tooltip', :alt => t('helper.add_information_to_hitchhike'))
  end

  def gender_people_image(gender)
    if gender == 'male'
      image_tag("icons/male.png", :class => 'tooltip', :alt => t('helper.male_people'))
    elsif gender == 'female'
      image_tag("icons/female.png", :class => 'tooltip', :alt => t('helper.female_people'))
    elsif gender == 'mixed'
      image_tag("icons/mixed_gender.png", :class => 'tooltip', :alt => t('helper.mixed_people'))
    end
  end

  def gender_image(gender)
    if gender == 'male'
      image_tag("icons/male.png", :class => 'tooltip', :alt => t('helper.male'))
    elsif gender == 'female'
      image_tag("icons/female.png", :class => 'tooltip', :alt => t('helper.female'))
    end
  end

  def experience_image(exp)
    if exp == 'positive'
      image_tag("icons/bullet_green.png", :class => 'tooltip', :alt => t('helper.positive_experience'))
    elsif exp == 'neutral'
      image_tag("icons/bullet_yellow.png", :class => 'tooltip', :alt => t('helper.neutral_experience'))
    elsif exp == 'negative'
      image_tag("icons/bullet_red.png", :class => 'tooltip', :alt => t('helper.negative_experience'))
    end
  end

  def delete_ride_image
    image_tag("icons/cross.png", :class => 'tooltip', :alt => t('helper.delete_hitchhike'))
  end

  def delete_trip_image
    image_tag("icons/cross.png", :class => 'tooltip', :alt => t('helper.delete_trip'))
  end

  def user_image
    image_tag("icons/user.png", :class => 'tooltip')
  end

  def waiting_time_image(time=nil)
    if time.nil?
      image_tag("icons/time.png")
    else
      image_tag("icons/time.png", :class => 'tooltip', :alt => t('helper.waiting_time', :time => time))
    end
  end

  def waiting_time_missing_image
    image_tag("icons/time_delete.png", :class => 'tooltip', :alt => t('helper.waiting_time_missing'))
  end

  def ride_image(number)
    image_tag("icons/car.png", :class => 'tooltip', :alt => t('helper.rides', :count => number))
  end

  def driving_time_missing_image
    image_tag("icons/car_delete.png", :class => 'tooltip', :alt => t('helper.driving_time_missing'))
  end

  def photo_missing_image
    image_tag("icons/photo_delete.png", :class => 'tooltip', :alt => t('helper.photo_missing'))
  end

  def photo_image
    image_tag("icons/photo.png", :class => 'tooltip', :alt => t('helper.photo'))
  end

  def photo_image_button
    image_tag("icons/photo.png")
  end

  def story_image
    image_tag("icons/story.png", :class => 'tooltip')
  end

  def add_story_image
    image_tag("icons/story.png", :class => 'tooltip', :alt => t('helper.add_story_image'))
  end

  def story_missing_image
    image_tag("icons/script_delete.png", :class => 'tooltip', :alt => t('helper.story_missing'))
  end

  def add_image
    image_tag('icons/add.png', :class => 'tooltip', :alt => t('helper.add_information'))
  end

  def facebook_page
    link_to "Find Hitchlog On Facebook", 'https://www.facebook.com/profile.php?id=740638119', :id => 'facebook_button'
  end

  def twitter_account
    link_to "Find Hitchlog On Twitter", 'http://twitter.com/#!/hitchlog', :id => 'twitter_button'
  end

  def gmaps_duration_image(trip)
    image_tag("icons/google.png", :class => 'tooltip', :alt => t('helper.gmaps_duration', :duration => human_seconds(trip.gmaps_duration)))
  end

  def trip_duration_image(trip)
    image_tag("icons/car_red.png", :class => 'tooltip', :alt => t('helper.trip_duration', :duration => human_seconds(trip.duration)))
  end

  def driving_time_image(time)
    image_tag("icons/car.png", :class => 'tooltip', :alt => t('helper.driving_time', :time => time))
  end
end

