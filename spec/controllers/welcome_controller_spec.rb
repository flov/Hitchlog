require 'spec_helper'

describe WelcomeController do
  describe '#home' do
    it 'renders home template' do
      get :home

      response.should render_template(:home)
    end
  end

  describe '#about' do
    it 'renders about template' do
      get :about

      response.should render_template(:about)
    end
  end
end
