module UsersHelper
  def user_waited_averagely(user, average_waiting_time)
    "#{h(user)} waited averagely #{average_waiting_time} minutes per ride.<br/>".html_safe unless average_waiting_time.blank?
  end
  
  def user_waited_totally(user, total_waiting_time, waiting_time_array)
    unless total_waiting_time == 0
      "#{h(user)} waited a total number of #{total_waiting_time} minutes for #{pluralize(waiting_time_array.size, 'ride')}.<br/>".html_safe
    end
  end
  
  def average_drivers_age(user, avg_age)
    "#{h(user)} has been driven by people who were averagely #{avg_age} years old.<br/>".html_safe unless avg_age.blank?
  end
  
  def link_to_user(user)
    link_to(user, user_path(user))
  end

  def last_login_location(user)
    link_to user.sign_in_address.city, "http://maps.google.com/?q=#{user.sign_in_address.city}"
  end
end
