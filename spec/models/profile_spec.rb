# frozen_string_literal: true

require 'rails_helper'
require 'byebug'

RSpec.describe Profile, type: :model do
  describe 'name' do
    context 'blankのときに' do
      let(:profile) do
        build(:profile, name: '')
      end
      it 'invalidになる' do
        expect(profile).not_to be_valid
      end
    end
  end

  describe 'user_association' do
    context '関連がないとき' do
      let(:profile) do
        build(:profile, name: 'my name', user_id: '')
      end
      it 'invalidになる' do
        expect(profile).not_to be_valid
      end
    end
    context '関連があるとき' do
      let(:user) do
        create(:user, name: 'my name')
      end
      let(:profile) do
        build(:profile, { name: 'my name', user_id: user.id })
      end
      it 'validになる' do
        # byebug
        expect(profile).to be_valid
      end
    end
  end
end
