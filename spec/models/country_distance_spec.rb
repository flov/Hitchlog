describe CountryDistance do
  describe '#distance_in_kms' do
    it 'returns the distance in kms' do
      cd = FactoryGirl.build :country_distance, distance: 5400
      cd.distance_in_kms.should == 5
    end
  end
end
