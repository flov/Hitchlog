require 'spec_helper'

describe Hitchhike do
  it { should validate_presence_of :from }
  it { should validate_presence_of :to }
  it { should validate_presence_of :distance }
  it { should validate_numericality_of :distance }
end
