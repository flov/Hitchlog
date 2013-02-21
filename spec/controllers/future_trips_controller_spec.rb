require 'spec_helper'

describe FutureTripsController do
  describe "#new" do
    let(:action) { get :new }

    it_blocks_unauthenticated_access
  end

  describe "#edit" do
    let(:action) { get :edit, id: 1 }

    it_blocks_unauthenticated_access
  end

  describe "#create" do
    let(:action) { post :create, future_trip: { "from" => "foo" } }
    let(:current_user) { double('user', to_param: 'flov', id: 1) }
    let(:future_trip) { double('future_trip') }

    it_blocks_unauthenticated_access

    before :each do
      FutureTrip.stub new: future_trip
      sign_in :user, current_user
    end

    it 'creates a future trip and redirects to the profile page' do
      future_trip.should_receive(:user_id=).with(current_user.id)
      future_trip.stub save: true

      action

      response.should redirect_to(user_path('flov'))
    end

    it 'renders edit if there is invalid data' do
      future_trip.should_receive(:user_id=).with(current_user.id)
      future_trip.stub save: false

      action

      response.should render_template(:new)
    end
  end

  describe "#update" do
    let(:future_trip) { double('future_trip', id: 1) }
    let(:action) { put :update, id: future_trip.id, future_trip: { "from" => "foo" } }
    let(:current_user) { double('user', to_param: 'flov') }

    it_blocks_unauthenticated_access

    before :each do
      sign_in :user, current_user
      FutureTrip.stub find: future_trip
    end

    it 'updates a future trip and redirects to the profile page' do
      future_trip.stub(update_attributes: true)
      future_trip.should_receive(:attributes=).with("from" => "foo").and_return(true)

      action

      response.should redirect_to(user_path('flov'))
    end

    it 'renders edit if there is invalid data' do
      future_trip.stub update_attributes: false
      future_trip.stub 'attributes=' => false

      action

      response.should render_template(:edit)
    end
  end

  describe "#destroy" do
    let(:future_trip)  { double('future_trip', id: 1, from: 'Melbourne',
                                to: 'Sydnery', 'attributes=' => '', destroy: true) }
    let(:action)       { delete :destroy, id: future_trip.id }
    let(:current_user) { double('user', to_param: 'flov') }

    it_blocks_unauthenticated_access

    before :each do
      sign_in :user, current_user
      FutureTrip.stub find: future_trip
    end

    it 'deletes the future trip' do
      future_trip.should_receive(:destroy)

      action
    end

    it "redirects back to the user page" do
      action

      response.should redirect_to(user_path('flov'))
    end

    it "notes the change" do
      action

      flash[:notice].should == 'Your future trip from Melbourne to Sydnery has been deleted'
    end
  end
end
