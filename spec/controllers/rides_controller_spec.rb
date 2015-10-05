require 'rails_helper'

RSpec.describe RidesController, type: :controller do
  describe "#create" do
    let(:action) { post :create, id: '1' }

    it_blocks_unauthenticated_access
  end

  describe "#delete_photo" do
    let(:action) { post :delete_photo, id: '1' }

    it_blocks_unauthenticated_access
  end

  describe "#update" do
    let(:action) { put :update, id: '1' }

    it_blocks_unauthenticated_access
  end

  describe "#destroy" do
    let(:action) { delete :destroy, id: '1' }

    it_blocks_unauthenticated_access
  end
end
