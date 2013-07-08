module NavigationHelper
  def home_active
    if 'welcome#bootstrap' == "#{controller.controller_name}##{controller.action_name}"
      'active'
    end
  end

  def trips_active
    if 'trips' == controller.controller_name && controller.action_name != 'new'
      'active'
    end
  end

  def new_trip_active
    if 'trips' == controller.controller_name && controller.action_name == 'new'
      'active'
    end
  end

  def users_active
    if 'users' == controller.controller_name
      'active'
    end
  end

  def about_active
    if 'welcome#about' == "#{controller.controller_name}##{controller.action_name}"
      'active'
    end
  end
end
