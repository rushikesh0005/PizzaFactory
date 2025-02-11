class Topping < ApplicationRecord
  validates :name, :topping_type, :price, presence: true
  validates :topping_type, inclusion: { in: %w[veg non-veg] }
  has_and_belongs_to_many :order_items
  before_save :set_status_based_on_quantity
  private

  def set_status_based_on_quantity
    if quantity.present? && quantity > 0
      self.active = 0
    else
      self.active = 1
    end
  end
end