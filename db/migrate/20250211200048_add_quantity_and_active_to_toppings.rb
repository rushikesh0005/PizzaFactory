class AddQuantityAndActiveToToppings < ActiveRecord::Migration[8.0]
  def change
    add_column :toppings, :quantity, :integer,default: 0
    add_column :toppings, :active, :boolean,default: false
  end
end
