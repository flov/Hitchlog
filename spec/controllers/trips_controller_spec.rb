require 'spec_helper'

describe TripsController do
  describe 'GET show' do
    it { assigns[:trip] }
    it { assigns[:user] }
    it { assigns[:photo_rides] }
    it { assigns[:rides] }
  end

  describe 'GET index' do
    it "should be successful" do
      get :index, formats: "json"
      response.should be_success
    end

    it "should render index template" do
      get :index
      response.should render_template('index')
    end
  end

  describe 'POST create_coment' do
    context 'user is not logged in' do
      it "redirects to log in page" do
        post :create_comment
        response.should redirect_to('/en/hitchhikers/login')
      end
    end

    context 'user is logged in' do
      let(:comment) { mock_model(Comment).as_null_object }
      let(:trip)    { Factory.create(:trip) }
      let(:user)    { Factory.create(:user) }

      before do
        @user = Factory :user
        sign_in :user, @user
        comment.stub(:trip).and_return(trip)
        comment.stub(:user).and_return(user)
        Comment.stub(:new).and_return(comment)
      end

      it "creates a new comment" do
        Comment.should_receive(:new)
               .with(body: 'New Comment')
               .and_return(comment)
        post :create_comment, body: "New Comment"
      end

      context 'when the comment saves successfully' do
        before do
          comment.stub(:save).and_return(true)
        end

        it 'sets the notice flash' do
          post :create_comment
          flash[:notice].should_not be_empty
        end

      end

      context 'when the comment fails to save' do
        it 'sets the alert flash' do
          post :create_comment
          comment.stub(:save).and_return(false)
          flash[:alert].should eq("Comment failed to save!")
        end
      end

      it 'redirects to the trip page' do
        post :create_comment
        response.should redirect_to(trip_path(comment.trip))
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
        @user = Factory :user
        sign_in :user, @user
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

        it "assigns @trip" do
          post :create
          assigns[:trip].should eq(trip)
        end

        it "renders the edit action" do
          post :create
          response.should render_template(action: 'edit')
        end
      end
    end
  end
end
