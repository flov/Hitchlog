require 'spec_helper'

describe 'gmaps.rb' do
  include Gmaps
  context 'country search' do
    it 'should return the correct country' do
      Gmaps.country('London').should == 'United Kingdom'
    end
  
    it 'should set the address to unknown country if address not found' do
      Gmaps.country('faowjiefoijawe faweofmn awoiejaw').should == 'unknown'
    end
  end
  
  it 'should return a distance greater than 0' do
    Gmaps.distance('New York', 'Boston').should > 0
  end
end