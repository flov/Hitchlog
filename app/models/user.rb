class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :about_you, :cs_user, :gender

  concerned_with :oauth, :user_settings

  has_friendly_id :username

  # chart_image method
  include Chart

  has_many :rides, through: :trips
  has_many :trips, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_many :comments
  has_many :future_travels
  has_one  :sign_in_address

  validates :username, presence: true,
                       uniqueness: true,
                       format: {with: /^[ A-Za-z\d_-]+$/}

  before_validation  :sanitize_username

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

  def geocoded_address
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

  def sanitize_username
    self.username.downcase
  end
end
