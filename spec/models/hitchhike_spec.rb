require 'spec_helper'

describe Hitchhike do
  it { should validate_presence_of :from }
  it { should validate_presence_of :to }
end
