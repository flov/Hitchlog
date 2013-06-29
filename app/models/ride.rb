class Ride < ActiveRecord::Base  
  attr_accessible :title,
                  :mission,
                  :photo_file_name,
                  :story,
                  :waiting_time,
                  :date,
                  :duration,
                  :number,
                  :experience,
                  :gender,
                  :photo_caption

  belongs_to :user
  belongs_to :trip
  has_one :person, :dependent => :destroy

  accepts_nested_attributes_for :person, :allow_destroy => true

  scope :with_photo, where("photo_file_name IS NOT NULL")
  scope :with_story, where("title IS NOT NULL")

  mount_uploader :photo, PhotoUploader

  def to_s
    self.trip
  end

  def to_param
    origin = CGI::escape(self.trip.sanitize_address('from'))
    destin = CGI::escape(self.trip.sanitize_address('to'))

    "#{id}-#{origin}-to-#{destin}".parameterize
  end

  def delete_photo!
    self.photo = nil
    self.save!
  end

  def caption_or_title
    if photo_caption
      photo_caption
    elsif title
      title
    end
  end

  def markdown_story
    if not self.story.blank?
      RDiscount.new(self.story).to_html.html_safe 
    else
      ''
    end
  end
end
