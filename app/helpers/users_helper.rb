module UsersHelper
  def user_waited_averagely(user, average_waiting_time)
    "#{h(user)} waited averagely #{average_waiting_time} minutes per ride.<br/>".html_safe unless average_waiting_time.blank?
  end
  
  def user_waited_totally(user, total_waiting_time, waiting_time_array)
    unless total_waiting_time == 0
      "#{user} waited a total number of #{total_waiting_time} minutes for #{pluralize(waiting_time_array.size, 'ride')}." 
    end
  end
  
  def user_hitchhiked(user, hitchhikes, total_distance)
    "#{h(user)} has seen #{pluralize(hitchhikes.size, 'car')} from inside while hitchhiking ".html_safe +
    "and travelled #{h(total_distance)} kms this way.<br/>".html_safe
  end
  
  def link_to_user(user)
    link_to(user, user_path(user))
  end
end
