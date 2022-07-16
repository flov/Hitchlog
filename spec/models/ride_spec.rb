require 'rails_helper'

RSpec.describe Ride, type: :model do
  it { is_expected.to belong_to :trip }

  let(:ride) { FactoryBot.build :ride }

  describe 'valid?' do
    it 'validates experience' do
      ['very good', 'good', 'neutral', 'bad', 'very bad'].each do |experience|
        ride.experience = experience
        expect(ride).to be_valid
      end
      ride.experience = 'not an experience'
      expect(ride).not_to be_valid
    end

    it 'validates youtube link' do
      # Exactly 11 characters
      # Allowed symbols: a-z, A-Z, 0-9, -, and _
      ride.youtube = 'zCWXOVXGxWI'
      expect(ride).to be_valid

      ride.youtube = "<script>alert('hacked')</script>"
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

  describe "#to_firebase_document" do
    it "returns a hash with the ride attributes" do
      ride.save!
      ride.title = 'example title'
      ride.photo_caption = 'example caption for photo'
      ride.story = 'example story'
      ride.youtube = 'zCWXOVXGxWI'
      ride.experience = 'very good'
      ride.vehicle = 'car'
      ride.waiting_time = 15
      expect(ride.to_firebase_document).to eq({
        title: 'example title',
        photoCaption: 'example caption for photo',
        story: 'example story',
        youtube: 'zCWXOVXGxWI',
        experience: 'very good',
        vehicle: 'car',
        waitingTime: 15,
        tagList: [],
        photo: nil
      })
    end
  end
end
