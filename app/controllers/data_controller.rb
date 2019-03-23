class DataController < ApplicationController
  before_action :assign_data_presenter

  def country_map
  end

  def trips_count
  end

  def written_stories
  end

  private

  def assign_data_presenter
    @data_presenter = DataPresenter.new
  end
end
