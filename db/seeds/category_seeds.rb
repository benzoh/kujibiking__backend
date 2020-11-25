# frozen_string_literal: true

unless Category.exists?
  count = 1
  20.times do
    Category.create!(name: "test" + count.to_s , slug: "test_" + count.to_s)
    count += 1
  end
end
