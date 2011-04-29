require 'spec_helper'

describe Trip do
  it { should have_many(:rides) }
  it { should belong_to(:user) }
end
