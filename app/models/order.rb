class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user

  def calculate_total
    total = order_items.sum do |item|
      base_price = item.pizza.price + item.crust.price + (item.side&.price || 0)
      topping_price = item.pizza.size == "Large" ? item.toppings.drop(2).sum(&:price) : item.toppings.sum(&:price)
      base_price + topping_price
    end
    update(total_price: total)
  end
end