class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
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

  concerned_with :user_settings

  has_friendly_id :username

  # chart_image method
  include Chart

  default_scope order("id DESC")

  has_many :rides, through: :trips
  has_many :trips, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_many :comments
  has_many :future_trips

  validates :username, presence: true,
                       uniqueness: true,
                       format: {with: /^[\.A-Za-z\d_-]+$/}

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

  before_create :geocode, :reverse_geocode, if: lambda{ |obj| obj.current_sign_in_ip_changed? }

  def facebook_user?
    self.authentications.where(provider: 'facebook').any?
  end

  def to_s
    username.capitalize
  end

  def to_param
    username
  end

  def experiences
    self.trips.map{|trip| trip.rides}.flatten.map{|ride| ride.experience }
  end

  def experiences_in_percentage
    hash = {}
    self.experiences.uniq.each do |experience|
      hash[experience] = ( self.experiences.select{|exp| exp == experience}.size.to_f / self.experiences.size ).round(2)
    end
    hash
  end

  def genders
    self.trips.map{|trip| trip.rides}.flatten.map{|ride| ride.gender }.select{|gender| !gender.blank?}
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

  private

  def update_location_updated_at
    self.location_updated_at = Time.now
  end

  def sanitize_username
    self.username.downcase
  end
end
