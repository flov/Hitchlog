class Hitchhike < ActiveRecord::Base
  
  has_attached_file :photo, 
                    :styles => { :cropped => "100x100#", :large => "500x500>"}, 
                    :processors => [:cropper]
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_photo, :if => :cropping?
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def photo_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  end
  
  private
  
  def reprocess_photo
    photo.reprocess!
  end  
end
