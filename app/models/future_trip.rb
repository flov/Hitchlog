class FutureTrip < ActiveRecord::Base
  attr_accessible :from, :departure, :to, :description

  belongs_to :user

  validates :from, presence: true
  validates :to, presence: true
  validates :departure, presence: true
end
