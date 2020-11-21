# frozen_string_literal: true

require "rails_helper"

RSpec.describe Category, type: :model do
  describe "name" do
    context "blankの時に" do
      it "invalidになる" do
        category = build(:category, name: "")
        # category = Category.new(name: "", slug: "fuga")
        expect(category).not_to be_valid
      end
    end
    context 'maxlength' do
      context '30文字' do
        it 'to valid' do
          category = build(:category, name: "あ" * 30)
          # category = Category.new(name: "あ" * 30, slug: "fuga")
          expect(category).to be_valid
        end
      end
      context '31文字' do
        it 'to invalid' do
          category = build(:category, name: "あ" * 31)
          # category = Category.new(name: "あ" * 31, slug: "fuga")
          expect(category).not_to be_valid
        end
      end
    end
  end

  # こういう書き方もできる
  # it "invalidになる" do
  #   category = Category.new(name: "", slug: "fuga")
  #   expect(category).not_to be_valid
  # end
end
