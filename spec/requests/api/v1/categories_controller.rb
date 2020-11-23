# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Categories", type: :request do
  describe "GET /api/v1/categories#index" do
    before do
      create_list(:category, 3)
    end
    it "正常レスポンスコードが返ってくる" do
      get api_v1_categories_url
      expect(response.status).to eq 200
    end
    it "件数が正しく返ってくる" do
      get api_v1_categories_url
      json = JSON.parse(response.body)
      expect(json["categories"].length).to eq(3)
    end
    it "id降順にレスポンスが返ってくる" do
      get api_v1_categories_url
      json = JSON.parse(response.body)
      first_id = json["categories"][0]["id"]
      expect(json["categories"][1]["id"]).to eq(first_id - 1)
      expect(json["categories"][2]["id"]).to eq(first_id - 2)
    end
  end

  describe "GET /api/v1/categories#show" do
    let(:category) do
      create(:category, name: 'show test', slug: 'show_test')   
    end
    it "正常レスポンスコードが返ってくる" do
      get api_v1_category_url({id: category.id})
      expect(response.status).to eq 200
    end
    it "nameが正しく返ってくる" do
      get api_v1_category_url({id: category.id})
      json = JSON.parse(response.body)
      # Rails.logger.debug json
      expect(json["category"]["name"]).to eq("show test")
    end
    it '404' do
      get api_v1_category_url({id: category.id + 1})
      expect(response.status).to eq 404
    end
  end

  describe "POST /api/v1/categories#create" do
    let(:new_category) do
      attributes_for(:category, name: 'create test', slug: 'create_test')
    end
    it "正常レスポンスコードが返ってくる" do
      post api_v1_categories_url, params: new_category
      expect(response.status).to eq 200
    end
    it 'increment count' do
      Rails.logger.debug Category.count
      expect do
        post api_v1_categories_url, params: new_category
        Rails.logger.debug Category.count
      end.to change {Category.count}.by(1)
    end
    it 'return name, slug' do
      post api_v1_categories_url, params: new_category
      json = JSON.parse response.body
      expect(json['category']['name']).to eq('create test')
      expect(json['category']['slug']).to eq('create_test')
    end
    it 'return errors' do
      post api_v1_categories_url, params: {}
      json = JSON.parse response.body
      expect(json.key?('errors')).to be true
    end
  end

  describe 'PUT /api/v1/categories#update' do
    let(:update_param) do
      category = create(:category)
      update_param = attributes_for(:category, name: 'update test', slug: 'update_test')
      update_param[:id] = category.id
      update_param
    end
    it "正常レスポンスコードが返ってくる" do
      put api_v1_category_url({id: update_param[:id]}), params: update_param
      expect(response.status).to eq 200
    end
    it 'return correct data' do
      put api_v1_category_url({id: update_param[:id]}), params: update_param
      json = JSON.parse(response.body)
      expect(json['category']['name']).to eq('update test')
      expect(json['category']['slug']).to eq('update_test')
    end
    it 'return errors with bad params' do
      put api_v1_category_url({id: update_param[:id]}), params: {name: ''}
      json = JSON.parse(response.body)
      expect(json.key?('errors')).to be true
    end
    it 'return 404 when a not exist id' do
      put api_v1_category_url({id: update_param[:id] + 1}), params: update_param
      expect(response.status).to eq 404
    end
  end
end
