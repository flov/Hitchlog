require 'spec_helper'

describe Ride do
  it { should have_one :person }
  it { should belong_to :trip }

  describe "#caption_or_title" do
    it "returns caption_or_title or caption" do
      ride = Factory.build :ride, title: 'example title'
      ride.caption_or_title.should == 'example title'

      ride.photo_caption = 'example caption for photo'
      ride.caption_or_title.should == 'example caption for photo'
    end
  end
end
