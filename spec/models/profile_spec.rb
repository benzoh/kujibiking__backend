# frozen_string_literal: true

require 'rails_helper'

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
end
