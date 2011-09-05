class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  # attr_searchable :some_public_data, :some_more_searchable_stuff

  before_save :sanitize_username

  concerned_with :oauth, :user_settings

  has_friendly_id :username

  # chart_image method
  include Chart

  has_many :trips, :dependent => :destroy
  has_many :authentications, :dependent => :destroy

  validates :username, :presence => true, :uniqueness => true, :format => {:with => /^[A-Za-z\d_]+$/}

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

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
