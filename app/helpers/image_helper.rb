module ImageHelper
  def show_available_images_for_hitchhike(hitchhike)
    array = []
    array << photo_image if hitchhike.photo.file?
    array << user_image if hitchhike.person
    array << story_image if hitchhike.story
    string = array.join(' ')
    string.html_safe 
  end

  def user_image
    image_tag("icons/user.png")
  end
  
  def photo_image
    image_tag("icons/photo.png")
  end
  
  def story_image
    image_tag("icons/story.png")
  end
  
  def add_image
    image_tag('icons/add.png')
  end
end
