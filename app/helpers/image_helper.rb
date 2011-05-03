module ImageHelper
  def images_missing_for_trip(trip)
    images = []
    trip.rides.each do |ride|
      array = []
      array << photo_missing_image unless ride.photo.file?
      array << story_missing_image if ride.story.blank?
      array << waiting_time_missing_image unless ride.waiting_time
      array << driving_time_missing_image unless ride.duration
      images << link_to(array.join(' ').html_safe, edit_ride_path(ride))
    end
    images.join(' ').html_safe
  end

  def images_missing_for_ride(ride)
    array = []
    array << photo_missing_image unless ride.photo.file?
    array << story_missing_image if ride.story.blank?
    array << waiting_time_missing_image unless ride.waiting_time
    array << driving_time_missing_image unless ride.duration
    link_to array.join(' ').html_safe, edit_ride_path(ride)
  end

  def images_for_ride(ride)
    array = []
    array << gender_image(ride.person.gender) if ride.person
    array << waiting_time_image(human_minutes(ride.waiting_time)) if ride.waiting_time
    array << driving_time_image(human_hours(ride.duration)) if ride.duration
    array << photo_image if ride.photo.file?
    string = array.join(' ')
    string.html_safe 
  end

  def images_for_trip(trip)
    images = []
    trip.rides.each do |ride|
      images << gender_image(ride.person.gender) if ride.person
      images << waiting_time_image(human_minutes(ride.waiting_time)) if ride.waiting_time
      images << driving_time_image(human_hours(ride.duration)) if ride.duration
      images << photo_image if ride.photo.file?
    end
    string = images.join(' ')
    string.html_safe 
  end
  
  def hitchhiking_with_image(trip)
    unless trip.travelling_with.nil?
      case trip.travelling_with
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

  def alone_image
    image_tag("icons/alone.png", :class => 'tooltip', :alt => t('trips.helper.alone'))
  end

  def two_people_image
    image_tag("icons/two_people.png", :class => 'tooltip', :alt => t('trips.helper.two'))
  end

  def three_people_image
    image_tag("icons/three_people.png", :class => 'tooltip', :alt => t('trips.helper.three'))
  end

  def more_than_three_people_image  
    image_tag("icons/more_than_three_people.png", :class => 'tooltip', :alt => t('trips.helper.more_than_three'))
  end
  
 def add_information_image
    image_tag("icons/add.png", :class => 'tooltip', :alt => t('trips.helper.add_information_to_hitchhike'))
  end

  def gender_image(gender)
    if gender == 'male'
      image_tag("icons/male.png", :class => 'tooltip', :alt => t('trips.helper.male_driver'))
    else
      image_tag("icons/female.png", :class => 'tooltip', :alt => t('trips.helper.female_driver'))
    end
  end

  def delete_image
    image_tag("icons/cross.png", :class => 'tooltip', :alt => t('trips.helper.delete_hitchhike'))
  end

  def user_image
    image_tag("icons/user.png", :class => 'tooltip')
  end

  def waiting_time_image(time)
    image_tag("icons/time.png", :class => 'tooltip', :alt => t('trips.helper.waiting_time', :time => time))
  end

  def waiting_time_missing_image
    image_tag("icons/time_delete.png", :class => 'tooltip', :alt => t('trips.helper.waiting_time_missing'))
  end

  def ride_image(number)
    image_tag("icons/car.png", :class => 'tooltip', :alt => t('trips.helper.rides', :number => number))
  end

  def driving_time_image(time)
    image_tag("icons/car.png", :class => 'tooltip', :alt => t('trips.helper.driving_time', :time => time))
  end

  def driving_time_missing_image
    image_tag("icons/car_delete.png", :class => 'tooltip', :alt => t('trips.helper.driving_time_missing'))
  end

  def photo_missing_image
    image_tag("icons/photo_delete.png", :class => 'tooltip', :alt => t('trips.helper.photo_missing'))
  end
  
  def photo_image
    image_tag("icons/photo.png", :class => 'tooltip', :alt => t('trips.helper.photo'))
  end
  
  def story_image
    image_tag("icons/story.png", :class => 'tooltip')
  end
  
  def story_missing_image
    image_tag("icons/script_delete.png", :class => 'tooltip', :alt => t('trips.helper.story_missing'))
  end
  
  def add_image
    image_tag('icons/add.png', :class => 'tooltip', :alt => t('trips.helper.add_information'))
  end
end
