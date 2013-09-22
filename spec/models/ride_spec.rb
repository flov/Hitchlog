require 'spec_helper'

describe Ride do
  it { should have_one :person }
  it { should belong_to :trip }

  let(:ride) { FactoryGirl.build :ride }

  describe 'valid?' do
    xit 'validates experience' do
      Ride.experiences.each do |experience|
        ride.experience = experience
        ride.should be_valid
      end
      ride.experience = 'not an experience'
      ride.should_not be_valid
    end
  end

  describe "#caption_or_title" do
    it "returns caption_or_title or caption" do
      ride.title = 'example title'
      ride.caption_or_title.should == 'example title'

      ride.photo_caption = 'example caption for photo'
      ride.caption_or_title.should == 'example caption for photo'
    end
  end

  describe "#markdown_story" do
    it "parses the story attribute as markdown and returns html" do
      ride.story = "Wow\n==="
      ride.markdown_story.should == "<h1>Wow</h1>\n"
    end
  end
end
