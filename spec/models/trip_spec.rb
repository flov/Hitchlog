require 'spec_helper'

describe Trip do
  it { should have_many(:hitchhikes) }
  it { should belong_to(:user) }
end
