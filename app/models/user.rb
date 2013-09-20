class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email,
                  :password,
                  :password_confirmation,
                  :remember_me,
                  :username,
                  :about_you,
                  :cs_user,
                  :gender,
                  :lat,
                  :lng,
                  :city,
                  :location,
                  :country,
                  :country_code

  has_friendly_id :username

  default_scope order("id DESC")

  has_many :rides, through: :trips
  has_many :trips, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_many :comments
  has_many :future_trips

  validates :username, presence: true,
                       uniqueness: true,
                       format: {with: /^[A-Za-z\d_-]+$/}

  before_validation :sanitize_username
  before_validation :update_location_updated_at, if: 'location_changed?'

  geocoded_by :current_sign_in_ip, latitude: :lat, longitude: :lng
  reverse_geocoded_by :lat, :lng do |obj,results|
    if geo = results.first
      obj.city         = geo.city
      obj.country      = geo.country
      obj.country_code = geo.country_code
    end
  end

  before_create :geocode, :reverse_geocode

  def facebook_user?
    self.authentications.where(provider: 'facebook').any?
  end

  def to_s
    username.capitalize
  end

  def to_param
    username
  end

  def very_positive_experiences
    self.trips.joins(:rides).where( rides: {experience: 'extremely positive'}).size
  end

  def positive_experiences
    self.trips.joins(:rides).where( rides: {experience: 'positive'}).size
  end

  def neutral_experiences
    self.trips.joins(:rides).where( rides: {experience: 'neutral'}).size
  end

  def negative_experiences
    self.trips.joins(:rides).where( rides: {experience: 'negative'}).size
  end

  def very_negative_experiences
    self.trips.joins(:rides).where( rides: {experience: 'very negative'}).size
  end

  def genders
    self.trips.map(&:rides).flatten.map(&:gender).reject(&:blank?)
  end

  def genders_in_percentage
    hash = {}
    self.genders.uniq.each do |gender|
      hash[gender] = ( self.genders.select{|gen| gen == gender}.size.to_f / self.genders.size ).round(2)
    end
    hash
  end

  def formatted_address
    if city.present? && country.present?
      "#{city}, #{country}"
    elsif country.present?
      country
    elsif city.present?
      city
    else
      "Unknown"
    end
  end

  def hitchhiked_kms
    self.trips.map{|trip| trip.distance}.sum/1000
  end

  def no_of_rides
    self.rides.size
  end

  def hitchhiked_countries
    self.trips.map{|trip| trip.country_distances.map(&:country)}.flatten.uniq.size
  end

  def to_geomap
    hash = {"distances"=>{},"trip_count"=>{}}
    self.trips.flat_map(&:country_distances).each do |cd|
      if hash["distances"][Countries[cd.country]]
        hash["distances"][Countries[cd.country]] += cd.distance_in_kms
        hash["trip_count"][Countries[cd.country]] += 1
      else
        hash["distances"][Countries[cd.country]] = cd.distance_in_kms
        hash["trip_count"][Countries[cd.country]] = 1
      end
    end
    hash
  end

  def rides
    self.trips.map{|trip| trip.rides}.flatten
  end

  def average_waiting_time
    waiting_time = self.trips.map{|trip| trip.rides.map{|hh| hh.waiting_time}}.flatten.compact
    if waiting_time.size == 0
      nil
    else
      waiting_time.sum / waiting_time.size
    end
  end

  def average_drivers_age
    avg_drivers_age_array = self.rides.collect{|h| h.person.age if h.person}.compact
    avg_drivers_age_array.sum / avg_drivers_age_array.size unless avg_drivers_age_array.size == 0    
  end

  def stories
    rides.collect{|h| h.story}.compact.delete_if{|x| x == ''}
  end

  def number_of_photos
    rides.collect(&:photo_url).compact.size
  end

  private

  def update_location_updated_at
    self.location_updated_at = Time.now
  end

  def sanitize_username
    self.username = self.username.gsub('.', '_') if self.username.include? '.'
    self.username = self.username.downcase
  end
end
