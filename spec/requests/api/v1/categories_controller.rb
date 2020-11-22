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
end
