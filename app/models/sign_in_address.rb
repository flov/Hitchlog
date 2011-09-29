class SignInAddress < ActiveRecord::Base
  belongs_to :user

  def to_s
    if !city.blank? && !country.blank?
      "#{city}, #{country}"
    elsif !country.blank?
      country
    end
  end
end
