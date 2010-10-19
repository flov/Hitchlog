require 'spec_helper'

describe Hitchhike, 'valid' do
  it { should validate_presence_of :title }
  it { should validate_presence_of :from }
  it { should validate_presence_of :to }
end
