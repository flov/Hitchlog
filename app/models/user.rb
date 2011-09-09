class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username


  concerned_with :oauth, :user_settings

  has_friendly_id :username

  # chart_image method
  include Chart

  has_many :trips, :dependent => :destroy
  has_many :authentications, :dependent => :destroy
  has_one  :sign_in_address

  validates :username, :presence => true, :uniqueness => true, :format => {:with => /^[A-Za-z\d_]+$/}

  geocoded_by        :current_sign_in_ip, :latitude => :current_sign_in_lat, :longitude => :current_sign_in_lng, :address => :current_sign_in_address
  after_validation   :geocode, :geocode_address, :if => lambda{ |obj| obj.current_sign_in_ip_changed? }
  before_save        :sanitize_username

  def geocode_address
    if self.current_sign_in_ip
      if search = Geocoder.search(self.current_sign_in_ip).first
        self.sign_in_address            ||= SignInAddress.new
        self.sign_in_address.country      = search.country if search.country
        self.sign_in_address.country_code = search.country_code if search.country
        self.sign_in_address.city         = search.city if search.country
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

  private
  def sanitize_username
    self.username.downcase
  end
end
