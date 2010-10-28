require 'spec_helper'

describe HitchhikesController, 'routes' do
  it { should route(:get, '/hitchhikes').to(:action => 'index') }
end

describe HitchhikesController, 'GET to hitchhikes.json' do
  it "should succeed" do
    get :index, :format => 'json'
    response.should be_success
  end
end
