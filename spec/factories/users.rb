FactoryBot.define do
  factory :user do
    provider { 'email' }
    sequence(:email) { |n| "test#{n}@example.com" }
    uid { email }
    password { 'password' }
    remember_created_at { nil }
    sequence(:name) { |n| "user#{n}" }
    tokens { nil }
    admin { false }
  end
end
