require 'rails_helper'

RSpec.describe RidesController, type: :controller do
  # create
  # ---------------------------------------------
  describe "POST create" do
    let(:action) { post :create }
    let(:trip) { create(:trip) }

    it_blocks_unauthenticated_access

    context "logged in as owner of trip" do
      it "saves a new ride" do
        sign_in trip.user

        expect {
          post :create, {trip_id: trip.id, ride: attributes_for(:ride)}
        }.to change(Ride, :count).by(1)
      end
    end

    context "logged in as other user" do
      it "redirects" do
        sign_in double('user')

        post :create, {trip_id: trip.id, ride: attributes_for(:ride)}

        expect(response).to( redirect_to(root_path) )
      end
    end
  end

  describe "#delete_photo" do
    let(:action) { post :delete_photo, id: '1' }

    it_blocks_unauthenticated_access
  end

  describe "#update" do
    let(:action) { put :update, id: '1' }
    let(:ride)   { create(:ride) }

    it "renders edit ride view on validation failure" do
      sign_in ride.trip.user

      put(:update, { id: ride.id,
                     ride: attributes_for(:ride).merge!( youtube: '!!!' ) })

      expect(response).to render_template(:edit)
    end

    it_blocks_unauthenticated_access
  end

  describe "#destroy" do
    let(:action) { delete :destroy, id: '1' }

    it_blocks_unauthenticated_access
  end
end
