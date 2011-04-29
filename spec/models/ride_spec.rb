require 'spec_helper'

describe Hitchhike do
  it { should have_one :person }
  it { should belong_to :trip }
end
