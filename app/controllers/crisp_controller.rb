class CrispController < ApplicationController
  def charts
    render :charts, layout: 'minimal'
  end
end
