class Hitchhike
  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  after_update do 
    reprocess_photo if cropping?
  end
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def photo_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  end
end