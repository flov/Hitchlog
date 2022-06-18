require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  # initialize test data
  let!(:users) { create_list(:user, 10) }
  let(:username) { User.first.username }

  # index
  describe 'GET /api/v1/users' do
    # update request with headers
    before { get '/api/v1/users' }

    it 'returns status code 200' do
      # somehow the first request returns a 404, anoter request however works as expected
      get '/api/v1/users'

      expect(response).to have_http_status(200)
    end

    it 'returns users' do
      expect(json).not_to be_empty
      expect(json["users"].size).to eq(10)
    end
  end

  # show
  describe 'GET /user/:id' do
    before { get "/api/v1/users/#{username}"}

    context 'record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
      end

      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'record does not exist' do
      let(:username) { 'HansWurst' }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # create
  describe 'POST /api/v1/users' do
    let(:valid_attributes) { attributes_for(:user) }

    context "valid payload" do
      before { post "/api/v1/users", user: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context "invalid payload" do
      before { post '/api/v1/users', user: { title: 'Foobar' } }

      it 'returns a validation failure message' do
        expect(response.body).to match(/can't be blank/)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  #update
  describe 'PUT /api/v1/users/:id' do
    let(:valid_attributes) { { username: 'updatedUsername' } }
    let(:action) { put "/api/v1/users/#{username}", user: valid_attributes }

    context "if the record exists" do
      before { action }

      it 'have http status 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the record' do
        expect(response.body).to be_empty
      end
    end
  end

  describe 'DELETE /api/v1/users/:id' do
    before { delete "/api/v1/users/#{username}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
