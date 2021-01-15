# frozen_string_literal: true

require 'rails_helper'
require 'byebug'

#
# users controller test
#
RSpec.describe 'Api::V1::Users', type: :request do
  before do
    @user = create(:user, name: 'test user')
    @authorized_headers = authorized_user_headers(@user)
    admin_user = create(:user, { name: 'test admin user', admin: true })
    @authorized_admin_headers = authorized_user_headers(admin_user)
  end

  describe 'GET /api/v1/users#index' do
    before do
      create_list(:user, 3)
    end

    it '200が返る' do
      get api_v1_users_url, headers: @authorized_admin_headers
      expect(response.status).to eq 200
    end

    it '件数が正しく返る' do
      get api_v1_users_url, headers: @authorized_admin_headers
      json = JSON.parse(response.body)
      # byebug
      expect(json['users'].length).to eq(3 + 2) # headers用2件含む
    end

    it 'id降順にレスポンスが返る' do
      get api_v1_users_url, headers: @authorized_admin_headers
      json = JSON.parse(response.body)
      first_id = json['users'][0]['id']
      expect(json['users'][1]['id']).to eq(first_id - 1)
      expect(json['users'][2]['id']).to eq(first_id - 2)
      expect(json['users'][3]['id']).to eq(first_id - 3)
      expect(json['users'][4]['id']).to eq(first_id - 4)
    end
  end

  describe 'GET /api/v1/users#show' do
    it '200が返る' do
      get api_v1_user_url({ id: @user.id }), headers: @authorized_headers
      expect(response.status).to eq 200
    end

    it 'nameが正しく返る' do
      get api_v1_user_url({ id: @user.id }), headers: @authorized_headers
      json = JSON.parse(response.body)
      expect(json['user']['name']).to eq 'test user'
    end

    it '404が返る' do
      last_user = User.last
      get api_v1_user_url({ id: last_user.id + 1 }), headers: @authorized_headers
      # byebug
      expect(response.status).to eq 404
    end
  end

  describe 'POST /api/v1/users#create' do
    let(:new_user) do
      attributes_for(:user, name: 'test user', email: 'test_user@example.com', admin: true)
    end

    it '200が返る' do
      post api_v1_users_url, params: new_user, headers: @authorized_admin_headers
      expect(response.status).to eq 200
    end

    it 'ユーザ数が増える' do
      expect do
        post api_v1_users_url, params: new_user, headers: @authorized_admin_headers
      end.to change { User.count }.by(1)
    end

    it 'name, emailが返る' do
      post api_v1_users_url, params: new_user, headers: @authorized_admin_headers
      json = JSON.parse response.body
      expect(json['user']['name']).to eq 'test user'
      expect(json['user']['email']).to eq 'test_user@example.com'
      expect(json['user']['admin']).to be true
    end

    it 'エラー返る' do
      post api_v1_users_url, params: {}, headers: @authorized_admin_headers
      json = JSON.parse response.body
      expect(json.key?('errors')).to be true
    end
  end

  describe 'PATCH /api/v1/users#update' do
    let(:update_param) do
      update_param = attributes_for(:user, name: 'update test', email: 'update_test@example.com', admin: true)
      update_param[:id] = @user.id
      update_param
    end

    it '200返す' do
      patch api_v1_user_url({ id: update_param[:id] }), params: update_param, headers: @authorized_headers
      expect(response.status).to eq 200
    end

    it 'アップデートしたデータ返す' do
      patch api_v1_user_url({ id: update_param[:id] }), params: update_param, headers: @authorized_headers
      json = JSON.parse(response.body)
      expect(json['user']['name']).to eq 'update test'
      expect(json['user']['email']).to eq 'update_test@example.com'
      expect(json['user']['admin']).to be false # admin権限は書き換えできると困るのでfalseのまま
    end

    it 'パラメータ不備でエラー返す' do
      patch api_v1_user_url({ id: update_param[:id] }), params: { name: nil }, headers: @authorized_headers
      json = JSON.parse(response.body)
      expect(json.key?('errors')).to be true
    end

    it '存在しないIDのとき404返す' do
      last_user = User.last
      patch api_v1_user_url({ id: last_user.id + 1 }), params: update_param, headers: @authorized_admin_headers
      expect(response.status).to eq 404
    end
  end

  describe 'DELETE /api/v1/users#destroy' do
    it '200返す' do
      delete api_v1_user_url({ id: @user.id }), headers: @authorized_admin_headers
      expect(response.status).to eq 200
    end

    it '1件減る' do
      expect do
        delete api_v1_user_url({ id: @user.id }), headers: @authorized_admin_headers
      end.to change { User.count }.by(-1)
    end

    it '存在しないIDのとき404返す' do
      last_user = User.last
      delete api_v1_user_url({ id: last_user.id + 1 }), headers: @authorized_admin_headers
      expect(response.status).to eq 404
    end
  end
end
