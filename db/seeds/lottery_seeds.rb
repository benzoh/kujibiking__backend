# frozen_string_literal: true

if Lottery.exists?
  users = User.all
  users.each do |user|
    Random.rand(0..3).times do
      user.lotteries.create!(result: Faker::Lorem.word, memo: Faker::Lorem.paragraph)
    end
  end
end
