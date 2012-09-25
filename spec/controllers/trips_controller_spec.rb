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

  describe '#index' do
    it 'renders the index view' do
      get :index
      response.should render_template(:index)
    end
  end

  describe '#show' do
    let(:trip) { double('trip', user: double('user')) }

    it 'renders show view' do
      Trip.stub(:find){ trip }
      get :show, id: 1
      response.should render_template('show')
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
      Trip.stub(:find){ trip }
    end

    it_blocks_unauthenticated_access

    it 'renders the edit view' do
      sign_in :user, current_user

      action

      response.should render_template(:edit)
    end
  end

  describe '#create_comment' do
    let(:action) { post :create_comment, body: "New Comment", id: 1 }

    it_blocks_unauthenticated_access

    context 'user is logged in' do
      let(:trip)    { double('trip') }
      let(:user)    { double('user') }
      let(:comment) { double('comment', id: 1, trip: trip, user: user, :trip_id= => nil, :user_id= => nil) }

      before do
        sign_in :user, double('user', id: 2)

        Comment.stub(:new).and_return(comment)
        comment.should_receive(:trip_id=).with( '1' )
        comment.should_receive(:user_id=).with( 2 )
      end

      context 'comment saves succesfully' do
        before do
          comment.stub(:save).and_return(true)
          controller.stub(:notify_trip_owner_and_comment_authors)

          action
        end

        it 'sets the notice flash' do
          flash[:notice].should_not be_empty
        end

        it 'redirects to trip_path' do
          response.should redirect_to(trip_path(comment.trip))
        end
      end

      it 'sets the alert flash when the comment fails to save' do
        comment.stub(:save).and_return(false)

        action

        flash[:alert].should eq("Comment failed to save!")
      end
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
end
