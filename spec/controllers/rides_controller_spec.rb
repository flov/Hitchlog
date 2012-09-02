require 'spec_helper'

describe RidesController do
  describe '#show' do
    it 'should render json' do
      get :random, format: :json
      response.header['Content-Type'].should include 'application/json'
    end
  end

  describe '#random' do
    it 'should render json' do
      get :random, format: :json
      response.header['Content-Type'].should include 'application/json'
    end
  end
end
