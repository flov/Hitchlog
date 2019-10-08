require 'rails_helper'

RSpec.describe CountryDistance, type: :model do
  describe '#distance_in_kms' do
    it 'returns the distance in kms' do
      cd = FactoryBot.build :country_distance, distance: 5400
      expect(cd.distance_in_kms).to eq(5)
    end
  end
end
