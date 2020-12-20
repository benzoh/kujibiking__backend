# frozen_string_literal: true

require "rails_helper"
require 'byebug'

RSpec.describe "Api::V1::Lotteries", type: :request do
  describe "POST /api/v1/lotteries#create" do
    let(:authorized_headers) do
      user = create(:user)
      post api_v1_user_session_url, params: { email: user.email, password: "password" }
      headers = {}
      headers["access-token"] = response.header["access-token"]
      headers["client"] = response.header["client"]
      headers["uid"] = response.header["uid"]
      headers
    end
    let(:new_lottery) do
      attributes_for(:lottery, result: "テスト", memo: "memoテスト")
    end
    it "正常レスポンスコードが返ってくる" do
      post api_v1_lotteries_url, params: new_lottery, headers: authorized_headers
      expect(response.status).to eq 200
    end
    it "1件増えて返ってくる" do
      expect do
        post api_v1_lotteries_url, params: new_lottery, headers: authorized_headers
      end.to change { Lottery.count }.by(1)
    end
    it "正しく返ってくる" do
      post api_v1_lotteries_url, params: new_lottery, headers: authorized_headers
      json = JSON.parse(response.body)
      # TODO: ここから？？？
      expect(json["lottery"]["result"]).to eq("テスト")
      expect(json["lottery"]["memo"]).to eq("memoテスト")
    end
    it "不正パラメータの時にerrorsが返ってくる" do
      post api_v1_lotteries_url, params: {}, headers: authorized_headers
      # byebug
      json = JSON.parse(response.body)
      expect(json.key?("errors")).to be true
    end
  end
end
