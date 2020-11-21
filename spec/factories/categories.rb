# frozen_string_literal: true

FactoryBot.define do
  # raise
  factory :category do
    name { "category_name" }
    slug { "category_slug" }
  end
end
