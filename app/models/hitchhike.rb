class Hitchhike < ActiveRecord::Base  
  # used to create custom json (http://github.com/qoobaa/to_hash)
  # custom functions to get distances
  include ToHash  

  belongs_to :user
  belongs_to :trip
  has_one :person, :dependent => :destroy
  accepts_nested_attributes_for :person, :allow_destroy => true
  
  validates :trip_id, :presence => true
  
  concerned_with  :photo_procession
  
  scope :not_empty, where("photo_file_name IS NOT NULL OR title IS NOT NULL OR story IS NOT NULL OR duration IS NOT NULL OR waiting_time IS NOT NULL")
    
  before_save do
    if person.nil?
      build_person
    end  
  end
  
  def to_s
    arr = [title, person.to_s].compact
    arr << "waiting time: #{waiting_time} minutes" unless waiting_time.nil?
    arr << "duration of ride: #{duration} hours" unless duration.nil?
    arr.delete_if{|x| x==''}.join(', ')
  end
  
  def empty?
    [photo_file_name, title, story, waiting_time, duration, person.to_s].compact.delete_if{|x| x == '' }.empty?
  end

  def next
    result = Hitchhike.not_empty.where('id > ?', self.id).first
    result.nil? ? self.class.first.id : result.id
  end

  def prev
    result = Hitchhike.not_empty.where('id < ?', self.id).order('id DESC').first
    result.nil? ? self.class.last.id : result.id
  end
  
  def self.random_item
    not_empty.order('RAND()').first
  end
  
  def to_json
    hash = self.to_hash(:title, :story, :id, :next, :prev)
    hash[:from]     = trip.from
    hash[:to]       = trip.to
    hash[:date]     = trip.to_date
    hash[:distance] = trip.distance
    hash[:username] = trip.user.username
    hash[:rides]    = trip.hitchhikes.size
    hash[:person]   = person.build_hash
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