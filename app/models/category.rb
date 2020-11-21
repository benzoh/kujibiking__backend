class Category < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :slug, presence: true, length: { maximum: 15 }
end
