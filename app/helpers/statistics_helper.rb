module StatisticsHelper
  def trips_data(start = 1.year.ago)
    kms_by_month   = Trip.kms_by_month(start)
    trips_by_month = Trip.trips_by_month(start)

    (start.to_date..Time.now.to_date).select{ |date| date.day == 1 }.map do |date|
      {
        created_at: date,
        total_distance: kms_by_month[date].first["total_distance"],
        trips_count: trips_by_month[date].first["trips_count"]
      }
    end
  end

  def orders_chart_data
    orders_by_day = Order.total_grouped_by_day(2.weeks.ago)    
    (2.weeks.ago.to_date..Date.today).map do |date|
      {
        purchased_at: date,
        price: orders_by_day(date).first.try(:total_price) || 0
      }
    end
  end

  def hitchhikers_by_gender
    [
      { label: 'male hitchhikers', value: User.where(gender: "male").count },
      { label: 'female hitchhikers', value: User.where(gender: "female").count }
    ]
  end

  def experiences_data
    ['very good', 'neutral', 'bad', 'very bad'].map do |exp|
      {
        label: exp,
        value: Ride.where(experience: exp).count,
        ratio: Ride.send("#{exp.parameterize('_')}_experiences_ratio"),
      }
    end
  end
end
