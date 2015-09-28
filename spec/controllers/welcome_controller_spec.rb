require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe '#home' do
    it 'renders home template' do
      get :home

      expect(response).to render_template(:home)
    end
  end

  describe '#about' do
    it 'renders about template' do
      get :about

      expect(response).to render_template(:about)
    end
  end
end
