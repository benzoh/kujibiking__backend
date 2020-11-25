# frozen_string_literal: true

# ↓ 効いてない？
Faker::Config.locale = :ja

unless Category.exists?
  20.times do
    fake = Faker::Food.vegetables
    Category.create!(name: fake, slug: fake.parameterize)
  end
end
