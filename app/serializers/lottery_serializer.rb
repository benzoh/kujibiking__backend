class LotterySerializer < ActiveModel::Serializer
  attributes :id, :result, :memo

  belongs_to :user
end
