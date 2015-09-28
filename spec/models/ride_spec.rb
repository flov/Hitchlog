require 'rails_helper'

RSpec.describe Ride, type: :model do
  it { is_expected.to belong_to :trip }

  let(:ride) { FactoryGirl.build :ride }

  describe 'valid?' do
    it 'validates experience' do
      ['very good', 'good', 'neutral', 'bad', 'very bad'].each do |experience|
        ride.experience = experience
        expect(ride).to be_valid
      end
      ride.experience = 'not an experience'
      expect(ride).not_to be_valid
    end
  end

  describe "#caption_or_title" do
    it "returns caption_or_title or caption" do
      ride.title = 'example title'
      expect(ride.caption_or_title).to eq('example title')

      ride.photo_caption = 'example caption for photo'
      expect(ride.caption_or_title).to eq('example caption for photo')
    end
  end

  describe "#markdown_story" do
    it "parses the story attribute as markdown and returns html" do
      ride.story = "Wow\n==="
      expect(ride.markdown_story).to eq("<h1>Wow</h1>\n")
    end
  end
end
