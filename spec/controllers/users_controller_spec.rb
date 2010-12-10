require 'spec_helper'

describe UsersController, '#show' do
  it do
    @trip = Factory.create :trip
    2.times{Factory.create :hitchhike}
    get 'show'
    
    response.should_be success
  end
end
