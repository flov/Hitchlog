require 'spec_helper'

describe WelcomeController, 'routes' do
  it { should route(:get, '/welcome').to(:action => 'index') }
end
