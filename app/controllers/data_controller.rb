class DataController < ApplicationController
  before_action :assign_data_presenter

  def country_map
    @data = @data_presenter.trip_data_for_map
  end

  def trips_count
    @data = @data_presenter.trips_count_for_map
  end

  def written_stories
    @data = @data_presenter.hitchhikers_with_most_stories
  end

  private

  def assign_data_presenter
    @data_presenter = DataPresenter.new
  end
end
