# frozen_string_literal: true

Faker::Config.locale = :ja

if User.exists?
  10.times do |i|
    fake = Faker::Food.vegetables
    email = "test#{i + 1}_#{fake.parameterize}@example.com"
    User.create!(email: email, password: 'password',
                 uid: email, provider: 'email', name: Faker::Name.name)
  end
end
