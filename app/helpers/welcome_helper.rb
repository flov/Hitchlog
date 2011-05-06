module WelcomeHelper
  def flov
    "<a href='http://hitchlog.com/hitchhikers/flov'>Flov</a>".html_safe
  end

  def find_hitchlog_on_facebook
    link_to image_tag('omniauthbuttons/png/facebook_64.png'), 'https://www.facebook.com/pages/Hitchlog/106464962761282', :alt => 'Find Hitchlog On Facebook'
  end

  def find_hitchlog_on_twitter
    link_to image_tag('omniauthbuttons/png/twitter_64.png'), 'http://twitter.com/#!/hitchlog', :alt => 'Find Hitchlog On Twitter'
  end
end
