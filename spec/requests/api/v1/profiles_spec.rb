# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Profiles', type: :request do
  describe 'GET /api/v1/profiles' do
    it 'return responce code 200' do
      get api_v1_profiles_path
      expect(response).to have_http_status(200)
    end
  end

  # describe 'POST /api/v1/profiles#create' do
  #   let(:new_profile) do
  #     attributes_for(:profile, name: 'test name')
  #   end
  #   it 'return responce code 200' do
  #     post api_v1_profile_path, params: new_profile
  #     expect(response).to have_http_status(200)
  #   end
  # end
end
