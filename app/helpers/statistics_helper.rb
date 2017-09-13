module StatisticsHelper
  def trips_data(start = 1.year.ago)
    kms_by_month   = Trip.kms_by_month(start)
    trips_by_month = Trip.trips_by_month(start)
    sign_ups_data  = User.sign_ups_by_month(start)

    (start.to_date..Time.now.to_date).select{ |date| date.day == 1 }.map do |date|
      {
        created_at: date,
        total_distance: kms_by_month[date].first["total_distance"],
        trips_count: trips_by_month[date].first["trips_count"],
        sign_ups_count: sign_ups_data[date].first["users_count"]
      }
    end
  end

  def sign_ups_data(start = 1.year.ago)
    sign_ups_by_month = User.sign_ups_by_month(start)

    (start.to_date..Time.now.to_date).select{ |date| date.day == 1 }.map do |date|
      {
        created_at: date,
        sign_ups: sign_ups_by_month[date].first["users_count"]
      }
    end
  end

  def company_for_trips
    (0..3).map do |travelling_with|
      {
        label: t("helper.travelling_with_#{travelling_with}"),
        value: ((Trip.where(travelling_with: travelling_with).count / Trip.count.to_f) * 100).round
      }
    end
  end

  def vehicles_data
    Ride::VEHICLES.map do |vehicle|
      { label: I18n.t("rides.vehicles.#{vehicle}"), value: Ride.where(vehicle: vehicle).count }
    end
  end

  def total_trips_by_user
    User.select("username, count(*) as total_trips").joins(:trips).group('username').map do |user|
      { username: user.username, total_trips: user.total_trips}
    end
  end

  def hitchhikers_by_gender
    all_users_with_gender = User.where.not(gender: nil).where.not(gender:'').count
    [
      { label: I18n.t('general.male'),
        value: ((User.where(gender: "male").count.to_f / all_users_with_gender) * 100).round 
      },
      { label: I18n.t('general.female'),
        value: ((User.where(gender: "female").count.to_f / all_users_with_gender) * 100).round }
    ]
  end

  def experiences_data
    ['very good', 'good', 'neutral', 'bad', 'very bad'].map do |exp|
      {
        label: I18n.t("general.#{exp.parameterize('_')}"),
        value: Ride.send("#{exp.parameterize('_')}_experiences_ratio")
      }
    end
  end

  def top_10_hitchhikers
    User.top_10_hitchhikers.map do |user|
      {
        username: "#{user[:username].capitalize} #{User.find_by_username(user[:username]).gender[0]}",
        total_distance: user[:total_distance]
      }
    end
  end

  def average_age_of_hitchhikers
    array_of_ages = Trip.joins(:user).where.not(users: {date_of_birth: nil}).
      select(:id, :departure, :"users.date_of_birth").
      map{|trip| ((trip.departure.to_date - trip.date_of_birth) / 365).to_i }.
      delete_if{|x| x < 14 || x > 70}

    (array_of_ages.reduce(:+).to_f / array_of_ages.size).round
  end

  def age_for_trips
    array_of_ages = Trip.joins(:user).where.not(users: {date_of_birth: nil}).
      select(:id, :departure, :"users.date_of_birth").
      map{|trip| ((trip.departure.to_date - trip.date_of_birth) / 365).to_i }.
      delete_if{|x| x < 14 || x > 70}

    hash = {}
    array_of_ages.each do |age|
      if hash[age]
        hash[age] += 1
      else
        hash[age] = 1
      end
    end

    hash = Hash[hash.sort].map do |age, trips_count|
      {age: "#{age}", trips_count: trips_count}
    end
    hash
  end

  def waiting_time_data
    interval = 10
    array = (10..60).step(interval).map do |waiting_time|
      {
        label: "#{waiting_time - (interval-1)}-#{waiting_time} min",
        value: Ride.ratio_for_waiting_time_between(waiting_time - (interval-1), waiting_time)
      }
    end
    interval = 60
    array + (120..240).step(interval).map do |waiting_time|
      {
        label: "#{waiting_time - (interval-1)}-#{waiting_time} min",
        value: Ride.ratio_for_waiting_time_between(waiting_time - (interval-1), waiting_time)
      }
    end
  end
end
