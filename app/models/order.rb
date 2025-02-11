class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user
  validates :status, inclusion: { in: %w[pending confirmed completed] }

  def calculate_total
    total = order_items.includes(:pizza, :crust, :side).sum do |item|
      item.pizza.price + item.crust.price + (item.side&.price || 0)
    end
    update(total_price: total)
  end
end