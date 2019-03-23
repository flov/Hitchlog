class DataPresenter
  def trip_data_for_map
    hash = {}

    fill_experiences_to_hash(hash)
    fill_vehicles_to_hash(hash)
    fill_stories_to_hash(hash)
    fill_photos_to_hash(hash)
    fill_videos_to_hash(hash)

    hash
  end

  def trips_count_for_map
    hash = {}
    hash["trips_count"] = {}
    Trip.joins(:country_distances).distinct.
      select("country_code, count(*) as trips_count").
      group("country_code").map do |trip|
        hash["trips_count"][trip.country_code] = trip.trips_count
    end

    fill_stories_to_hash(hash)
    fill_photos_to_hash(hash)

    hash
  end

  def hitchhikers_with_most_stories
    Trip.joins(:user).
      joins(:rides).
      where.not(rides: {story: nil}).
      where.not(rides: {story: ''}).
      group('username').
      select('username, count(*) as stories').map do |user|
        { username: user.username,
          stories: user.stories }
      end.sort_by{ |hash| hash[:stories] }
  end

  private

  def fill_experiences_to_hash(hash)
    hash['trips_count'] = {}
    hash['total_good'] = {}
    hash['total_bad'] = {}
    Ride::EXPERIENCES.each do |experience|
      hash[experience.parameterize.underscore] = {}
      Trip.joins(:rides).
        where(rides: {experience: experience }).
        joins(:country_distances).
        distinct.
        select("country_code, count(*) as experience_count").
        group("country_code").map do |trip|
          hash[experience.parameterize.underscore][trip.country_code] = trip.experience_count
          if hash['trips_count'][trip.country_code]
            hash['trips_count'][trip.country_code] += trip.experience_count
          else
            hash['trips_count'][trip.country_code] = trip.experience_count
          end
        end
    end

    ["good", "bad"].each do |xp|
      hash["total_#{xp}"] = hash[xp].clone
      hash["very_#{xp}"].keys.each do |country_code|
        if hash["total_#{xp}"][country_code]
          hash["total_#{xp}"][country_code] += hash["very_#{xp}"][country_code]
        else
          hash["total_#{xp}"][country_code] = hash["very_#{xp}"][country_code]
        end
      end

      hash["total_#{xp}"].keys.each do |country_code|
        hash["#{xp}_ratio"] = {} if hash["#{xp}_ratio"].nil?
        hash["#{xp}_ratio"][country_code] =
          ((hash["total_#{xp}"][country_code].to_f / hash["trips_count"][country_code])*100).round(1)
      end
    end
  end

  def fill_vehicles_to_hash(hash)
    Ride::VEHICLES.each do |vehicle|
      Trip.joins(:rides).
        where(rides: {vehicle: vehicle}).
        joins(:country_distances).pluck(:country_code).each do |country_code|
        fill_hash(hash, vehicle, country_code)
        fill_hash(hash, "rides_with_vehicle", country_code)
      end
    end
    Ride::VEHICLES.each do |vehicle|
      hash["#{vehicle}_ratio"] = {} if hash["#{vehicle}_ratio}"].nil?
      hash[vehicle].keys.each do |country_code|
        hash["#{vehicle}_ratio"][country_code] =
          ((hash[vehicle][country_code].to_f / hash["rides_with_vehicle"][country_code])*100).round
      end
    end
  end

  def fill_stories_to_hash(hash)
    Trip.includes(:rides, :country_distances).where.not(rides: { story: nil }).
      where.not(rides: { story: '' }).
      pluck(:country_code).each do |country_code|
        fill_hash(hash, "stories", country_code)
    end
  end

  def fill_videos_to_hash(hash)
    Trip.joins(:rides).where.not(rides: { youtube: nil }).
      joins(:country_distances).pluck(:country_code).each do |country_code|
        fill_hash(hash, "videos", country_code)
    end
  end

  def fill_photos_to_hash(hash)
    Trip.joins(:rides).where.not(rides: { photo: nil }).
      joins(:country_distances).pluck(:country_code).each do |country_code|
        fill_hash(hash, "photos", country_code)
    end
  end

  def fill_hash(hash, topic, country_code)
    hash[topic] = {} if hash[topic].nil?
    if hash[topic][country_code]
      hash[topic][country_code] += 1
    else
      hash[topic][country_code] = 1
    end
  end
end
