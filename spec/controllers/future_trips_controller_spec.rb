require 'rails_helper'

RSpec.describe FutureTripsController, type: :controller do
  describe "#new" do
    let(:action) { get :new }
  end

  describe "#edit" do
    let(:action) { get :edit, id: 1 }

    it_blocks_unauthenticated_access
  end

  describe "#create" do
    let(:action) { post :create, future_trip: { "from" => "foo" } }
    let(:current_user) { double('user', to_param: 'flov', id: 1) }
    let(:future_trip) { double('future_trip', 'attributes=' => '') }

    it_blocks_unauthenticated_access

    before :each do
      allow(FutureTrip).to receive_messages new: future_trip
      sign_in current_user
    end

    it 'creates a future trip and redirects to the profile page' do
      expect(future_trip).to receive(:user_id=).with(current_user.id)
      allow(future_trip).to receive_messages save: true

      action

      expect(response).to redirect_to(user_path('flov'))
    end

    it 'renders edit if there is invalid data' do
      expect(future_trip).to receive(:user_id=).with(current_user.id)
      allow(future_trip).to receive_messages save: false

      action

      expect(response).to render_template(:new)
    end
  end

  describe "#update" do
    let(:future_trip) { double('future_trip', id: 1) }
    let(:action) { put :update, id: 1, future_trip: { "from" => "foo" } }
    let(:current_user) { double('user', to_param: 'flov') }

    it_blocks_unauthenticated_access

    before :each do
      sign_in current_user
      allow(FutureTrip).to receive(:find).and_return future_trip
    end

    it 'updates a future trip and redirects to the profile page' do
      expect(future_trip).to receive(:update_attributes).and_return(true)

      action

      expect(response).to redirect_to(user_path('flov'))
    end

    it 'renders edit if there is invalid data' do
      expect(future_trip).to receive(:update_attributes).and_return(false)
      allow(future_trip).to receive_messages 'attributes=' => false

      action

      expect(response).to render_template(:edit)
    end
  end

  describe "#destroy" do
    let(:future_trip)  { double('future_trip', id: 1, from: 'Melbourne',
                                to: 'Sydnery', 'attributes=' => '', destroy: true) }
    let(:action)       { delete :destroy, id: future_trip.id }
    let(:current_user) { double('user', to_param: 'flov') }

    it_blocks_unauthenticated_access

    before :each do
      sign_in current_user
      allow(FutureTrip).to receive_messages find: future_trip
    end

    it 'deletes the future trip' do
      expect(future_trip).to receive(:destroy)

      action
    end

    it "redirects back to the user page" do
      action

      expect(response).to redirect_to(user_path('flov'))
    end

    it "notes the change" do
      action

      expect(flash[:success]).to eq('Your future trip from Melbourne to Sydnery has been deleted')
    end
  end
end
