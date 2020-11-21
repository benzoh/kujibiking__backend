# frozen_string_literal: true

require "rails_helper"

RSpec.describe Category, type: :model do
  describe "name" do
    context "blankの時に" do
      let(:category) do
        build(:category, name: "")
      end
      it "invalidになる" do
        expect(category).not_to be_valid
      end
    end
    context 'maxlength' do
      context '30文字' do
        let(:category) do
          build(:category, name: "あ" * 30)
        end
        it 'to valid' do
          expect(category).to be_valid
        end
      end
      context '31文字' do
        let(:category) do
          build(:category, name: "あ" * 31)
        end
        it 'to invalid' do
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
