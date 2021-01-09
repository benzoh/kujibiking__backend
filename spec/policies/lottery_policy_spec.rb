# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LotteryPolicy, type: :policy do
  let(:user) { User.new }
  let(:admin_user) { create(:user, :admin) }
  let(:lottery) { create(:lottery) }

  subject { described_class }

  permissions :index?, :show? do
    it '未ログインの時に許可' do
      expect(subject).to permit(nil, lottery)
    end
  end

  permissions :create? do
    it '未ログインの時に不許可' do
      expect(subject).not_to permit(nil, lottery)
    end
    it 'ログインしている時に許可' do
      expect(subject).to permit(user, lottery)
    end
  end

  permissions :update?, :destroy? do
    it '未ログインの時に不許可' do
      expect(subject).not_to permit(nil, lottery)
    end
    it 'ログインしているが別ユーザーの時に不許可' do
      expect(subject).not_to permit(user, lottery)
    end
    it 'ログインしていて同一ユーザーの時に許可' do
      lottery.user = user
      expect(subject).to permit(user, lottery)
    end
    it '管理者権限では、他ユーザのデータを操作できる' do
      expect(subject).to permit(admin_user, lottery)
    end
  end
end
