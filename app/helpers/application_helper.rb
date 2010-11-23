module ApplicationHelper
  def include_gmaps_javascripts
    if Rails.env == 'development'
      javascript_include_tag 'gmaps_offline'
    else
      "<script src='http://maps.google.com/maps/api/js?sensor=false' type='text/javascript'></script>"
    end
  end
end
