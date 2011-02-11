module ImageHelper
  def show_available_images_for_hitchhike(hitchhike)
    array = []
    array << photo_image if hitchhike.photo.file?
    array << driver_image(hitchhike.person.gender) if hitchhike.person
    array << story_image if hitchhike.story
    string = array.join(' ')
    string.html_safe 
  end

  def driver_image(gender)
    if gender == 'male'
      image_tag("icons/male.png", :class => 'tooltip', :alt => t('trips.helper.male_driver'))
    else
      image_tag("icons/female.png", :class => 'tooltip', :alt => t('trips.helper.female_driver'))
    end
  end

  def user_image
    image_tag("icons/user.png", :class => 'tooltip')
  end
  
  def photo_image
    image_tag("icons/photo.png", :class => 'tooltip', :alt => t('trips.helper.photo'))
  end
  
  def story_image
    image_tag("icons/story.png", :class => 'tooltip')
  end
  
  def add_image
    image_tag('icons/add.png', :class => 'tooltip', :alt => t('trips.helper.add_information'))
  end
end
