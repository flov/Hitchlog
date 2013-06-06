# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, show_title = true)
    content_for(:title) { page_title.to_s }
    @show_title = show_title
  end
  
  def meta_keywords(keywords = nil)
    if keywords.nil?
      "<meta name='keywords' content='hitchhiking,hitchhiker,blog,free travel,autostop,trampen' /> ".html_safe
    else
      "<meta name='keywords' content='#{keywords}' /> ".html_safe
    end
  end
  
  def meta_description(description=nil)
    "<meta name='description' content='#{I18n.t('meta.description')}'/>".html_safe
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
end
