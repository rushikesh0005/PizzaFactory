class Inventory < ApplicationRecord
  validates :item_type, :item_id, :stock, presence: true
end