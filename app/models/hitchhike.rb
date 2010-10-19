class Hitchhike < ActiveRecord::Base
  
  has_attached_file :photo, 
    :styles => { :small => "200x100#", :large => "600x300>" }, 
    :storage => :s3,
    :s3_credentials => "#{Rails.root.to_s}/config/s3.yml",
    # :processors => [:cropper],
    :path => ":attachment/:id/:style.:extension"
    # :bucket => 'hitchhike.heroku.com'
                            
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :people
  after_update :reprocess_photo, :if => :cropping?
  
  has_many :people
  accepts_nested_attributes_for :people, :allow_destroy => true

  validates_presence_of :title, :from, :to

  named_scope :next, lambda { |i| {:conditions => ["#{self.table_name}.id > ?", i.id], :order => "#{self.table_name}.id ASC"} }  

  def path
    self.photo.url(:large)
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  # def photo_geometry(style = :original)
  #   @geometry ||= {}
  #   @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  # end
  
  def next
    result = self.class.find(:first, :conditions => ['id > ?', self.id], :order => 'id ASC')
    if result == nil
      self.class.first
    else
      result
    end
  end
  
  def prev
    result = self.class.find(:first, :conditions => ['id < ?', self.id], :order => 'id DESC')
    if result == nil
      self.class.last
    else
      result
    end
  end
  
  def next_id
    self.next.id
  end
  
  def prev_id
    self.prev.id
  end
  
  def build_hash
    hash = self.to_hash(:title, :from, :to, :id, :next_id, :prev_id,
                       [:people,{:name=>:name,
                         :origin => :origin,
                         :occupation => :occupation,
                         :mission => :mission}]) 
    hash[:photo] = {:large => self.photo.url, :small => self.photo.url(:large)}  
    hash
  end
  
  private
  
  def reprocess_photo
    photo.reprocess!
  end
end
