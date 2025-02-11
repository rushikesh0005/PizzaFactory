class CreateJoinTableOrderItemsToppings < ActiveRecord::Migration[8.0]
  def change
    create_join_table :order_items, :toppings do |t|
      # t.index [:order_item_id, :topping_id]
      # t.index [:topping_id, :order_item_id]
    end
  end
end
