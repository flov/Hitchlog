class FutureTripMailer < ActionMailer::Base
  default from: "no-reply@hitchlog.com"

  def nearby_hitchhikers(future_trip, user)
    @future_trip, @user = future_trip, user
    mail(
      subject: t('mailer.future_trips.nearby_hitchhikers.subject', user: user, from_city: future_trip.from, to_city: future_trip.to)
    )
  end
end
