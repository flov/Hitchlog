require 'spec_helper'

describe Ride do
  it { should have_one :person }
  it { should belong_to :trip }
  it "validates presence of story if title is present" do
    ride = Ride.new(title: 'new title, but no story')
    ride.should have(1).error_on(:story)
  end
  it "validates presence of title if story is present" do
    ride = Ride.new(story: 'story but no title')
    ride.should have(1).error_on(:title)
  end
  
end
