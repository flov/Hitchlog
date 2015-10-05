require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  describe '#new' do
    let(:action) { get :new }

    it_blocks_unauthenticated_access

    let(:trip) { double('trip') }

    it 'renders show view' do
      sign_in double(:user)
      allow(Trip).to receive(:new){ trip }

      action

      expect(response).to render_template(:new)
    end
  end

  describe '#index' do
    it 'renders the index view' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe '#show' do
    let(:trip) { double('trip', visits: 0) }

    context "trip wasn't found" do
      it 'redirects if trip wasn not found' do
        get :show, id: 'doesnt exist!'

        expect(response).to redirect_to(root_path)
      end
    end

    context "Trip found" do
      before do
        allow(trip).to receive :update_column
        allow(Trip).to receive_message_chain(:includes, :find){ trip }

      end

      it 'renders show view' do
        get :show, id: 1

        expect(response).to render_template('show')
      end
    end
  end

  describe '#index' do
    it "renders index view" do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe '#edit' do
    let(:current_user) { double('user') }
    let(:trip)   { double('trip', user: current_user, rides: [] ) }
    let(:action) { get :edit, id: 1 }

    before do
      allow(Trip).to receive_message_chain(:includes, :find){ trip }
    end

    it_blocks_unauthenticated_access

    it 'renders the edit view' do
      sign_in current_user

      action

      expect(response).to render_template(:edit)
    end
  end

  describe 'POST create' do
    let(:action) { post :create }

    it_blocks_unauthenticated_access

    let(:current_user) { double('current_user ') }
    let(:trip) { double('trip', to_s: "1", save: true, 'user=' => '') }

    before do
      sign_in current_user
      allow(Trip).to receive(:new).and_return(trip)
    end

    it "creates a new trip" do
      expect(Trip).to receive(:new).
           with("from" => "Tehran").
           and_return(trip)
      post :create, :trip => { "from" => "Tehran" }
    end

    it "saves the trip" do
      expect(trip).to receive(:save)
      post :create
    end

    context "when the trip saves successfully" do
      before do
        allow(trip).to receive(:save).and_return(true)
        allow(trip).to receive(:id).and_return('1')
      end

      it "redirects to the trips index" do
        post :create
        expect(response).to redirect_to(action: "edit", id: '1')
      end
    end

    context "when the trip fails to save" do
      before do
        allow(trip).to receive(:save).and_return(false)
      end

      it "renders the new action" do
        post :create
        expect(response).to render_template('new')
      end
    end
  end

  describe '#add_ride' do
    let(:current_user) { double(:user) }
    let(:trip) { double( 'trip', id: 1, add_ride: true, user: current_user, to_param: '1' ) }
    let(:action) { post :add_ride, id: 1 }

    context 'logged in but not owner of ride' do
      it 'blocks access' do
        sign_in double(:different_user)
        action
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
