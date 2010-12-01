class Hitchhike < ActiveRecord::Base  
  # used to create custom json (http://github.com/qoobaa/to_hash)
  # custom functions to get distances
  include ToHash  

  has_attached_file :photo, 
                    :styles => { :cropped => "500x250#", :large => "800x400>" },
                    :processors => [:cropper]
  
  belongs_to :user
  belongs_to :trip
  has_one :person, :dependent => :destroy
  
  concerned_with  :photo_procession

  accepts_nested_attributes_for :person, :allow_destroy => true

  def to_s
    arr = [title, mission, person.to_s].compact
    arr << "waiting time: #{waiting_time}" unless waiting_time.nil?
    arr << "duration of ride: #{duration}" unless duration.nil?
    arr.delete_if{|x| x==''}.join(', ')
  end

  def next
    result = Hitchhike.where('id > ?', self.id).first
    result.nil? ? self.class.first.id : result.i
  end

  def prev
    result = Hitchhike.where('id < ?', self.id).order('id DESC').first
    result.nil? ? self.class.last.id : result.id
  end
  
  def to_json
    hash = self.to_hash(:title, :id, :next, :prev, :story)
    hash[:username] = self.user.username
    hash[:person] << person.build_hash
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