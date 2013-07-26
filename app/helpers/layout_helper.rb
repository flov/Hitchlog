# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, show_title = true)
    content_for(:title) { page_title.to_s }
  end

  def meta_keywords(keywords = nil)
    content_for :head do
      if keywords.nil?
        "<meta name='keywords' content='hitchhiking,hitchhiker,blog,free travel,autostop,trampen' /> ".html_safe
      else
        "<meta name='keywords' content='#{keywords}' /> ".html_safe
      end
    end
  end

  def meta_description(description=nil)
    content_for :head do
      "<meta name='description' content='#{description}'/>".html_safe
    end
  end
end
