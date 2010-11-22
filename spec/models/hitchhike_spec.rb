require 'spec_helper'

describe Hitchhike do
  it { should validate_presence_of :from }
  it { should validate_presence_of :to }
  it { should belong_to :user }
  it { should have_many :people }
end
