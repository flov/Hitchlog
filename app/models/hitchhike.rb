class Hitchhike < ActiveRecord::Base  
  # used to create custom json (http://github.com/qoobaa/to_hash)
  include ToHash

  has_attached_file :photo, 
                    :styles => { :cropped => "500x250#", :large => "800x400>" },
                    :processors => [:cropper]
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  after_update do 
    reprocess_photo if cropping?
  end
  
  concerned_with  :validation

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def photo_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  end
  
  def next
    result = Hitchhike.where('id > ?', self.id).first
    result.nil? ? self.class.first.id : result.id
  end

  def prev
    result = Hitchhike.where('id < ?', self.id).order('id DESC').first
    result.nil? ? self.class.last.id : result.id
  end
  
  def to_json
    hash = self.to_hash(:title, :from, :to, :id, :next, :prev, :distance)
    if self.photo.file?
      hash[:photo] = {:small => self.photo.url(:cropped), :large => self.photo.url(:original)} 
    else
      hash[:photo] = {:small => '/images/missingphoto.jpg', :large => '/images/missingphoto.jpg'} 
    end
    JSON.pretty_generate(hash)
  end

      
  private
  
  def reprocess_photo
    photo.reprocess!
  end  
end