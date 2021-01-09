# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  let(:user) { User.new }
  let(:another_user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }

  subject { described_class }

  permissions '.scope' do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :index?, :create?, :destroy? do
    it '未ログインの時に不許可' do
      expect(subject).not_to permit(nil, user)
    end
    it '管理者でなければ不可' do
      expect(subject).not_to permit(user, user)
    end
    it '管理者のみ閲覧可能' do
      expect(subject).to permit(admin_user, user)
    end
  end

  permissions :show?, :update? do
    it '未ログインの時に不許可' do
      expect(subject).not_to permit(nil, user)
    end
    it 'ログインしているが別ユーザーの時に不許可' do
      expect(subject).not_to permit(user, another_user)
    end
    it '管理者は閲覧可能' do
      expect(subject).to permit(admin_user, user)
    end
    it '自分自身は閲覧可能' do
      expect(subject).to permit(user, user)
    end
  end
end
