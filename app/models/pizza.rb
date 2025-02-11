class Pizza < ApplicationRecord
  has_many :order_items
  validates :name, :category, :price, presence: true
end