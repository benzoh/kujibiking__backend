# frozen_string_literal: true

require 'rails_helper'
require 'byebug'

RSpec.describe 'Api::V1::Profiles', type: :request do
  let(:authorized_headers) do
    authorized_user_headers
  end

  describe 'GET /api/v1/profiles' do
    it 'return response code 200' do
      get api_v1_profiles_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/v1/profiles#create' do
    let(:user) { create(:user, name: 'test name') }
    # let(:user) { attributes_for(:user, name: 'test name') }
    let(:new_profile) do
      attributes_for(:profile, { name: 'test name', user_id: user.id })
    end

    it 'return response code 200' do
      # byebug
      post api_v1_profiles_path, params: new_profile
      expect(response.status).to eq 200
    end

    it 'return collect data' do
      post api_v1_lotteries_url, params: new_profile
      json = JSON.parse(response.body)
      # byebug
      expect(json['profile']['name']).to eq 'test name'
    end

    it 'Errors are returned when the parameter is invalid' do
      post api_v1_lotteries_url, params: new_profile
      json = JSON.parse(response.body)
      expect(json.key?('errors')).to be true
    end
  end

  describe 'GET /api/v1/profiles#show' do
    let(:user) { create(:user, name: 'test name') }
    let(:new_profile) do
      attributes_for(:profile, { name: 'test name', user_id: user.id })
    end

    it 'return response code 200' do
      # byebug
      get api_v1_profile_path({ id: new_profile.id })
      expect(response.status).to eq 200
    end

    it 'name is returned correctly' do
      get api_v1_profile_path({ id: new_profile.id })
      json = JSON.parse(response.body)
      expect(json['profile']['name']).to eq('test name')
    end

    it '404' do
      get api_v1_profile_path({ id: new_profile.id + 1 })
      expect(response.status).to eq 404
    end
  end

  describe 'PUT /api/v1/profiles#update' do
    let(:update_param) do
      profile = create(:profile)
      update_param = attributes_for(:profile, name: 'update test')
      update_param[:id] = profile.id
      update_param
    end

    it 'return response code 200' do
      put api_v1_profile_url({ id: update_param.id }), params: update_param
      expect(response.status).to eq 200
    end

    it 'return correct data' do
      put api_v1_profile_url({ id: update_param.id }), params: update_param
      json = JSON.parse(response.body)
      expect(json['profile']['name']).to eq('update test')
    end

    it 'return errors with bad params' do
      put api_v1_profile_url({ id: update_param.id }), params: { name: '' }
      json = JSON.parse(response.body)
      expect(json.key?('errors')).to be true
    end

    it 'return 404 when a not exist id' do
      put api_v1_profile_url({ id: update_param.id + 1 }), params: update_param
      expect(response.status).to eq 404
    end
  end

  describe 'DELETE /api/v1/profiles#delete' do
    let(:delete_post) do
      create(:profile)
    end

    it 'res 200' do
      delete api_v1_profile_url({ id: delete_post.id })
      expect(response.status).to eq 200
    end

    it 'return one less' do
      delete_post
      expect do
        delete api_v1_profile_url({ id: delete_post })
      end.to change { Profile.count }.by(-1)
    end

    it 'res 404' do
      delete api_v1_profile_url({ id: delete_post.id + 1 })
      expect(response.status).to eq 404
    end
  end
end
