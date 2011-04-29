class Ride
  has_attached_file :photo, 
                    :styles => { :cropped => "500x250#", :large => "800x400>", :thumb  => "80x80>" },
                    :processors => [:cropper],
                    :default_url => "/images/missingphoto.jpg"                    
  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  after_update do 
    reprocess_photo if cropping?
  end
  
  def delete_photo!
    self.photo = nil
    self.save!
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def photo_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  end
  
  def reprocess_photo
    photo.reprocess!
  end
end
