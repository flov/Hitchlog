class ChangeExperienceDefaultForTrip < ActiveRecord::Migration
  def up
    Ride.find_each do |ride|
      case ride.experience
      when 'extremely positive'
        ride.update_column(:experience, 'very good')
      when 'positive'
        ride.update_column(:experience, 'good')
      when 'extremely negative'
        ride.update_column(:experience, 'very bad')
      when 'negative'
        ride.update_column(:experience, 'bad')
      end
    end
  end

  def down
  end
end
