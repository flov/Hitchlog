require 'spec_helper'

describe Comment do
  it { should belong_to(:trip) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:body) }
end
