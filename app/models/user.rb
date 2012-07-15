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

  has_many :trips, :dependent => :destroy
  has_many :authentications, :dependent => :destroy
  has_many :comments
  has_one  :sign_in_address

  validates :username, :presence => true, :uniqueness => true, :format => {:with => /^[ A-Za-z\d_-]+$/}

  before_validation  :sanitize_username
  before_save        :geocode_address, :if => lambda{ |obj| obj.current_sign_in_ip_changed? }
  geocoded_by :current_sign_in_ip, :latitude => :sign_in_lat, :longitude => :sign_in_lng

  def facebook_user?
    self.authentications.where(provider: 'facebook').any?
  end

  def geocode_address
    if self.current_sign_in_ip && Rails.env != 'test'
      if search = Geocoder.search(self.current_sign_in_ip).first
        self.build_sign_in_address if self.sign_in_address.nil?
        self.sign_in_address.country      = search.country
        self.sign_in_address.country_code = search.country_code
        self.sign_in_address.city         = search.city
        self.sign_in_lat                  = search.latitude
        self.sign_in_lng                  = search.longitude
      end
    end
  end

  def to_s
    username.capitalize
  end

  def to_param
    username
  end

  def rides
    trips.collect{|trip| trip.rides}.flatten
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

  private
  def sanitize_username
    self.username.downcase
  end
end
