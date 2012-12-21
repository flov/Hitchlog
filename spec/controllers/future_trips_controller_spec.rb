require 'spec_helper'

describe FutureTripsController do
  describe "#new" do
    let(:action) { get :new }

    it_blocks_unauthenticated_access
  end

  describe "#edit" do
    let(:action) { get :edit }

    it_blocks_unauthenticated_access
  end

  describe "#create" do
    let(:action) { get :create }

    it_blocks_unauthenticated_access
  end

  describe "#update" do
    let(:action) { put :update }

    it_blocks_unauthenticated_access
  end

  describe "#destroy" do
    let(:action) { delete :destroy }

    it_blocks_unauthenticated_access
  end
end
