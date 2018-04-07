class Ride < ActiveRecord::Base  
  EXPERIENCES = ['very good',
                 'good',
                 'neutral',
                 'bad',
                 'very bad']

  VEHICLES    = ['car',
                 'bus',
                 'truck',
                 'motorcycle',
                 'plane',
                 'boat']

  GENDER      = ['male',
                 'female',
                 'mixed']

  validates_inclusion_of :experience, in: EXPERIENCES
  validates_inclusion_of :vehicle,    in: VEHICLES,    allow_blank: true
  validates_inclusion_of :gender,     in: GENDER,      allow_blank: true

  belongs_to :user
  belongs_to :trip

  scope :with_photo, -> { where.not(photo: nil) }
  scope :with_story, -> { where("story <> ''") }
  scope :with_story_or_photo, -> { where("story <> '' OR photo IS NOT NULL") }
  scope :latest_first, -> { order('created_at DESC') }
  scope :oldest_first, -> { order('created_at ASC') }

  scope :very_good_experiences, -> { where(experience: "very good") }
  scope :good_experiences,      -> { where(experience: "good") }
  scope :neutral_experiences,   -> { where(experience: "neutral") }
  scope :bad_experiences,       -> { where(experience: "bad") }
  scope :very_bad_experiences,  -> { where(experience: "very bad") }

  mount_uploader :photo, PhotoUploader

  acts_as_taggable

  Ride::EXPERIENCES.each do |exp|
    define_singleton_method "#{exp.parameterize("_")}_experiences_ratio" do
      (( self.send("#{exp.parameterize("_")}_experiences").count.to_f / self.count ) * 100 ).round(2)
    end
  end

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
      RDiscount.new(self.story, :smart, :filter_html).to_html.html_safe
    else
      ''
    end
  end

  def self.ratio_for_waiting_time_between(starts, ends)
    total_rides = Ride.where("waiting_time != ?", 0).where('waiting_time is not null').count
    ((where(waiting_time: starts..ends).count.to_f / total_rides) * 100).round
  end

  private

  def self.ransackable_attributes(auth_object = nil)
    super & %w(title story experience photo vehicle)
  end
end
