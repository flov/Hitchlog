require 'spec_helper'

describe RidesController do
  describe 'GET random' do
    it { assigns[:ride] }
    it 'should render json' do
      get :random, format: :json
      response.header['Content-Type'].should include 'application/json'
    end
  end
end
