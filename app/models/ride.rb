class Ride < ActiveRecord::Base  
  # used to create custom json (http://github.com/qoobaa/to_hash)
  # custom functions to get distances
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  belongs_to :user
  belongs_to :trip
  has_one :person, :dependent => :destroy
  accepts_nested_attributes_for :person, :allow_destroy => true

  # scope :not_empty, where("photo_file_name IS NOT NULL OR title IS NOT NULL OR story IS NOT NULL OR duration IS NOT NULL OR waiting_time IS NOT NULL")
  scope :not_empty, where("duration IS NOT NULL OR photo_file_name IS NOT NULL OR waiting_time IS NOT NULL")
  scope :with_photo, where("photo_file_name IS NOT NULL")
  scope :with_story, where("story <> ''")

  has_attached_file :photo,
                    :styles => { :cropped => "500x250#", :large => "800x400>", :thumb  => "80x80>" },
                    :processors => [:cropper],
                    :default_url => "/images/missingphoto.jpg"

  after_update do
    reprocess_photo if cropping?
  end

  def to_s
    self.trip
  end

  def to_param
    from_param = trip.from.strip.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-')
    to_param   = trip.to.strip.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-')
    "#{id}-#{from_param}->#{to_param}"
  end

  def empty?
    [photo_file_name, title, story, waiting_time, duration, person.nil?].compact.delete_if{|x| x == '' || x == true}.empty?
  end

  def no_in_trip
    trip.rides.index(self) + 1
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
