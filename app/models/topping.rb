class Topping < ApplicationRecord
  validates :name, :topping_type, :price, presence: true
  validates :topping_type, inclusion: { in: %w[veg non-veg] }
end