# frozen_string_literal: true

unless Category.exists?
  count = 1
  20.times do
    Category.create!(name: "test" + count , slug: "test_" + count)
    count += 1
  end
end
