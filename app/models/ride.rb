class Ride < ActiveRecord::Base  
  # used to create custom json (http://github.com/qoobaa/to_hash)
  # custom functions to get distances
  include ToHash  

  belongs_to :user
  belongs_to :trip
  has_one :person, :dependent => :destroy
  accepts_nested_attributes_for :person, :allow_destroy => true
  
  validates :trip_id, :presence => true
  
  concerned_with  :photo_procession
  
  # scope :not_empty, where("photo_file_name IS NOT NULL OR title IS NOT NULL OR story IS NOT NULL OR duration IS NOT NULL OR waiting_time IS NOT NULL")
  scope :not_empty, where("story IS NOT NULL AND story <> '' OR photo_file_name IS NOT NULL")
  scope :with_photo, where("photo_file_name IS NOT NULL")
  scope :with_story, where("story IS NOT NULL AND story <> ''")
  
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
  
  def next
    result = Ride.not_empty.where('id > ?', self.id).first
    result.nil? ? self.class.not_empty.first : result
  end

  def prev
    result = Ride.not_empty.where('id < ?', self.id).order('id DESC').first
    result.nil? ? self.class.not_empty.last : result
  end
  
  def self.random_item
    not_empty.order('RAND()').first
  end
  
  def to_json
    hash = self.to_hash(:title, :story, :id)
    hash[:next]     = "/rides/#{self.next.to_param}"
    hash[:prev]     = "/rides/#{self.prev.to_param}"
    hash[:from]     = trip.from
    hash[:to]       = trip.to
    hash[:date]     = trip.to_date
    hash[:distance] = trip.distance
    hash[:username] = trip.user.username
    hash[:rides]    = trip.rides.size
    hash[:person]   = person.build_hash if person
    if self.photo.file?
      hash[:photo] = {:small => self.photo.url(:cropped), :large => self.photo.url(:original)} 
    else
      hash[:photo] = {:small => '/images/missingphoto.jpg', :large => '/images/missingphoto.jpg'} 
    end
    JSON.pretty_generate(hash)
  end

  def no_in_trip
    trip.rides.index(self) + 1
  end  
end
