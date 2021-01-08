# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LotteryPolicy, type: :policy do
  let(:user) { User.new }
  let(:lottery) { create(:lottery) }

  subject { described_class }

  permissions '.scope' do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :index?, :show? do
    it '未ログインの時に許可' do
      expect(memo).to permit(nil, lottery)
    end
  end

  permissions :create? do
    it '未ログインの時に不許可' do
      expect(memo).not_to permit(nil, lottery)
    end
    it 'ログインしている時に許可' do
      expect(memo).to permit(user, lottery)
    end
  end

  permissions :update?, :destroy? do
    it '未ログインの時に不許可' do
      expect(memo).not_to permit(nil, lottery)
    end
    it 'ログインしているが別ユーザーの時に不許可' do
      expect(memo).not_to permit(user, lottery)
    end
    it 'ログインしていて同一ユーザーの時に許可' do
      lottery.user = user
      expect(memo).to permit(user, lottery)
    end
  end
end
