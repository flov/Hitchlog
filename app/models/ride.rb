class Ride < ActiveRecord::Base  
  attr_accessible :title,
                  :mission,
                  :story,
                  :waiting_time,
                  :date,
                  :duration,
                  :number,
                  :experience,
                  :gender,
                  :photo,
                  :photo_cache,
                  :photo_caption

  belongs_to :user
  belongs_to :trip
  has_one :person, :dependent => :destroy

  accepts_nested_attributes_for :person, :allow_destroy => true

  scope :with_photo, where("photo IS NOT NULL")
  scope :with_story, where("title <> ''")

  mount_uploader :photo, PhotoUploader

  def to_s
    self.trip
  end

  def to_param
    origin = CGI::escape(self.trip.sanitize_address('from'))
    destin = CGI::escape(self.trip.sanitize_address('to'))

    "#{id}-#{origin}-to-#{destin}".parameterize
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
