class Side < ApplicationRecord
  has_many :order_items
  before_save :set_status_based_on_quantity

  private

  def set_status_based_on_quantity
    if quantity.present? && quantity > 0
      self.status = 'active'
    else
      self.status = 'inactive'
    end
  end
end