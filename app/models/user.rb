class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable,
         :validatable, :omniauthable, :omniauth_providers => [:facebook]

  has_many :rides, through: :trips
  has_many :trips, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :future_trips, dependent: :destroy

  validates :username, presence: true,
                       uniqueness: true,
                       format: {with: /\A[A-Za-z\d_-]+\z/}

  before_validation :sanitize_username
  before_validation :update_location_updated_at, if: 'location_changed?'

  scope :latest_first, -> { order("id DESC") }

  geocoded_by :current_sign_in_ip, latitude: :lat, longitude: :lng
  reverse_geocoded_by :lat, :lng do |obj,results|
    if geo = results.first
      obj.city         = geo.city
      obj.country      = geo.country
      obj.country_code = geo.country_code
    end
  end

  def facebook_user?
    self.provider == 'facebook'
  end

  def to_s
    username.capitalize
  end

  def to_param
    username
  end

  def very_good_experiences
    self.trips.joins(:rides).where( rides: {experience: 'very good'}).size
  end

  def good_experiences
    self.trips.joins(:rides).where( rides: {experience: 'good'}).size
  end

  def neutral_experiences
    self.trips.joins(:rides).where( rides: {experience: 'neutral'}).size
  end

  def bad_experiences
    self.trips.joins(:rides).where( rides: {experience: 'bad'}).size
  end

  def very_bad_experiences
    self.trips.joins(:rides).where( rides: {experience: 'very bad'}).size
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
    self.trips.pluck(:distance).sum/1000
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
    self.trips.map(&:rides).flatten
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

  def vehicles
    hash = {}
    rides.collect(&:vehicle).compact.reject(&:empty?).each do |vehicle|
      if hash[vehicle]
        hash[vehicle] += 1
      else
        hash[vehicle] = 1
      end
    end
    hash
  end

  def average_speed
    avg_speed_of_trips = self.trips.collect(&:average_speed).map(&:to_i)
    "#{avg_speed_of_trips.sum / avg_speed_of_trips.size} kmh"
  end

  def age
    ((Date.today - date_of_birth) / 365).to_i if date_of_birth
  end

  def age_of_trips
    return unless date_of_birth

    hash = {}

    self.trips.map(&:age).each do |age|
      if hash[age]
        hash[age] += 1
      else
        hash[age] = 1
      end
    end

    hash.to_a.sort
  end

  def self.choose_username(username)
    i = 1
    while User.exists?(username: username)
      username = "#{username.split(/\d/)[0]}#{i}"
      i += 1
    end
    username
  end

  def self.total_trips_by_user
    select("username, count(*) as total_trips").
      joins(:trips).
      group('username').map do |user|
        { username: user.username, total_trips: user.total_trips.to_i }
      end.sort_by{|hash| hash[:total_trips] }
  end

  def self.top_10_hitchhikers
    q = User.joins(:trips)
    q = q.select("username, sum(trips.distance) as total_distance")
    q = q.group('username')
    q.map{|user| {username: user.username, total_distance: user.total_distance.to_i / 1000}}.
      sort_by{|a| a[:total_distance]}[-11..-1]
  end

  def self.sign_ups_by_month(start)
    q = User.select("date_trunc('month', created_at) as ordered_date, count(*) as users_count")
    q = q.where(created_at: start.beginning_of_month..Time.now)
    q = q.group('ordered_date').order('ordered_date')
    q.map(&:attributes).group_by { |hash| hash["ordered_date"].to_date }
  end

  def self.from_omniauth(auth)
    graph = Koala::Facebook::API.new(auth.credentials.token)
    fb_info = graph.get_object("me", {fields: "birthday,gender"})

    user = User.where(provider: auth.provider, uid: auth.uid).first_or_create do |u|
      u.email            = auth.info.email
      u.gender           = fb_info["gender"]
      u.date_of_birth    = Date.strptime(fb_info["birthday"], '%m/%d/%Y')
      u.username         = self.choose_username(auth.info.name.split(' ').first)
      u.oauth_token      = auth.credentials.token
      u.oauth_expires_at = Time.at(auth.credentials.expires_at)
      u.provider         = auth.provider
      u.uid              = auth.uid
      u.name             = auth.info.name
      u.password         = Devise.friendly_token[0,20]
      u.uid              = auth.uid
      u.provider         = auth.provider
      u.name             = auth.info.name
      u.oauth_token      = auth.credentials.token
      u.oauth_expires_at = Time.at(auth.credentials.expires_at)
    end
    user.confirm
    user
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
