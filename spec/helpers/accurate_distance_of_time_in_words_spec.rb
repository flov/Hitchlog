require 'rails_helper'

RSpec.describe "A more accurate distance_of_time_in_words" do
  include AccurateDistanceOfTimeInWordsHelper

  describe "accurate distance of time" do
    [
      [4.5.minutes, "4 minutes"],
      [1.hour.to_i, "1 hour"],
      [2.hours + 5.minutes, "2 hours and 5 minutes"],
      [1.day + 2.hours + 30.minutes, "1 day, 2 hours, and 30 minutes"]
    ].each do |number, result|
      it "#{number} == #{result}" do
        expect(accurate_distance_of_time_in_words(number)).to eql(result)
      end
    end
  end
end
