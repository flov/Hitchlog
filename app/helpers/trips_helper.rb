module TripsHelper
  def trip_date(trip)
    @month_array ||= []
    if !trip.date.nil? && !@month_array.include?(trip.date.strftime("%B%y"))
      @month_array << trip.date.strftime("%B%y")
      date = trip.date.strftime("<h3 class='date'>%B<strong>%y</strong></h3>").html_safe unless trip.date.nil?
    else
      date = ''
    end
    date
  end
end
