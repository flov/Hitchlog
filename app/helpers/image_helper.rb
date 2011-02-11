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
      image_tag("icons/male.png", :alt => t('.male_driver')) 
    else
      image_tag("icons/female.png", :alt => t('.female_driver'))
    end
  end
  
  def photo_image
    image_tag("icons/photo.png", :alt => t('.photo'))
  end
  
  def story_image
    image_tag("icons/story.png")
  end
  
  def add_image
    image_tag('icons/add.png')
  end
end
