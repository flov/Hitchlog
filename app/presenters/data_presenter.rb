class DataPresenter
  def trip_data_for_map
    hash = {}

    fill_experiences_to_hash(hash)
    fill_vehicles_to_hash(hash)
    fill_stories_to_hash(hash)
    fill_photos_to_hash(hash)

    hash
  end

  def trips_count_for_map
    hash = {}

    trip_ids = Trip.joins(:rides).pluck(:id).uniq
    CountryDistance.where(trip_id: trip_ids).pluck(:country_code).each do |country_code|
      fill_hash(hash, "trips_count", country_code)
    end
    fill_stories_to_hash(hash)
    fill_photos_to_hash(hash)

    hash
  end

  private

  def fill_experiences_to_hash(hash)
    Ride::EXPERIENCES.map{|x| x.parameterize.underscore}.each do |experience|
      trip_ids = Trip.joins(:rides).where(rides: {experience: experience.humanize.downcase}).pluck(:id).uniq
      CountryDistance.where(trip_id: trip_ids).pluck(:country_code).each do |country_code|
        fill_hash(hash, experience, country_code)
        fill_hash(hash, "trips_count", country_code)
        if ["good", "very_good"].include? experience
          fill_hash(hash, "total_good", country_code)
        elsif ["bad", "very_bad"].include? experience
          fill_hash(hash, "total_bad", country_code)
        end
      end
    end

    ["good", "bad"].each do |xp|
      hash["total_#{xp}"].keys.each do |country_code|
        hash["#{xp}_ratio"] = {} if hash["#{xp}_ratio"].nil?
        hash["#{xp}_ratio"][country_code] =
          ((hash["total_#{xp}"][country_code].to_f / hash["trips_count"][country_code])*100).round
      end
    end
  end

  def fill_vehicles_to_hash(hash)
    Ride::VEHICLES.each do |vehicle|
      Trip.joins(:rides).where(rides: {vehicle: vehicle}).joins(:country_distances).pluck(:country_code).each do |country_code|
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
