require 'spec_helper'

describe TripsController do
  describe '#new' do
    let(:trip) { double('trip') }

    it 'blocks unauthenticated access' do
      get :new

      response.should redirect_to(new_user_session_path)
    end

    it 'renders show view' do
      sign_in :user, double(:user)
      Trip.stub(:new){ trip }

      get :new

      response.should render_template(:new)
    end
  end

  describe '#create_comment' do
    let(:comment) { double('comment') }

    it 'blocks unauthenticated access' do
      post :create_comment

      response.should redirect_to(new_user_session_path)
    end
  end

  describe '#index' do
    it 'renders the index view' do
      get :index
      response.should render_template(:index)
    end
  end

  describe '#show' do
    let(:trip) { double('trip', visits: 0) }

    context "trip wasn't found" do
      it 'redirects if trip wasn not found' do
        get :show, id: 'doesnt exist!'

        response.should redirect_to(root_path)
      end
    end

    context "Trip found" do
      before do
        trip.stub :update_column
        Trip.stub_chain(:includes, :find){ trip }

      end

      it 'renders show view' do
        get :show, id: 1

        response.should render_template('show')
      end
    end
  end

  describe '#index' do
    it "renders index view" do
      get :index
      response.should render_template('index')
    end
  end

  describe '#edit' do
    let(:current_user) { double('user') }
    let(:trip)   { double('trip', user: current_user, rides: [] ) }
    let(:action) { get :edit, id: 1 }

    before do
      Trip.stub_chain(:includes, :find){ trip }
    end

    it_blocks_unauthenticated_access

    it 'renders the edit view' do
      sign_in :user, current_user

      action

      response.should render_template(:edit)
    end
  end

  describe 'POST create' do
    context 'user is not logged in' do
      it "redirects to log in page" do
        post :create
        response.should redirect_to('/en/hitchhikers/login')
      end
    end

    context 'user is logged in' do
      let(:trip) { mock_model(Trip).as_null_object }

      before do
        @user = FactoryGirl.create :user
        sign_in :user, double('user')
        Trip.stub(:new).and_return(trip)
      end

      it "creates a new trip" do
        Trip.should_receive(:new).
             with("from" => "Tehran").
             and_return(trip)
        post :create, :trip => { "from" => "Tehran" }
      end

      it "saves the trip" do
        trip.should_receive(:save)
        post :create
      end

      context "when the trip saves successfully" do
        before do
          trip.stub(:save).and_return(true)
          trip.stub(:id).and_return('1')
        end

        it "redirects to the trips index" do
          post :create
          response.should redirect_to(action: "edit", id: '1')
        end
      end

      context "when the trip fails to save" do
        before do
          trip.stub(:save).and_return(false)
        end

        it "renders the edit action" do
          post :create
          response.should render_template(action: 'edit')
        end
      end
    end
  end

  describe '#add_ride' do
    let(:current_user) { double(:user) }
    let(:trip) { double( 'trip', id: 1, add_ride: true, user: current_user, to_param: '1' ) }
    let(:action) { post :add_ride, id: 1 }

    context 'logged in but not owner of ride' do
      it 'blocks access' do
        sign_in :user, double(:different_user)
        action
        response.should redirect_to(root_path)
      end
    end
  end
end
