# frozen_string_literal: true

FactoryBot.define do
  # raise
  factory :lottery do
    result { "result value" }
    memo { "memo value" }
    user
  end
end
