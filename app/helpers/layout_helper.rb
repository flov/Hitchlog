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
      raw("<meta name='keywords' content='hitchhiking,logs,hitchhiker,free travel,autostop,trampen' /> ")
    else
      raw("<meta name='keywords' content='#{keywords}' /> ")
    end
  end
  
  def meta_description(description=nil)
    "<meta name='description' content='A website for logging hitchhikes and personal hitchhiking stories. It uses the data to generate demographic statistics and show some overview about the experiences of hitchhikers.'/>"
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
