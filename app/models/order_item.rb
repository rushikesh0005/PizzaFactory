class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :pizza
  belongs_to :crust
  belongs_to :side, optional: true
  has_and_belongs_to_many :toppings 

  validate :validate_toppings

  def validate_toppings
    if pizza.category == "vegetarian" && toppings.any? { |t| t.topping_type == "non-veg" }
      errors.add(:toppings, "Veg pizza can't have non-veg toppings")
    end

    if pizza.category == "non-vegetarian" && toppings.any? { |t| t.name == "Paneer" }
      errors.add(:toppings, "Non-veg pizza can't have paneer topping")
    end
  end

  def reduce_inventory
    pizza.decrement!(:quantity) if pizza.quantity.present?

    crust.decrement!(:quantity) if crust.quantity.present?

    side.decrement!(:quantity) if side.present? && side.quantity.present?
    toppings.each do |topping|
      topping.decrement!(:quantity) if topping.quantity.present?
    end
  end
end