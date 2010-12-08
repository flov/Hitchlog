require 'spec_helper'

describe User, 'valid' do
  it { should have_many(:trips) }
end