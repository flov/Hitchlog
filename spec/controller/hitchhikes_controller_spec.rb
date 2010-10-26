require 'spec_helper'

describe HitchhikesController, 'routes' do
  it { should route(:get, '/').to(:action => 'index') }
end