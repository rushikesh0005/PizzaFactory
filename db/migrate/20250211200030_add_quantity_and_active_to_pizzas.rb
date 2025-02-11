class AddQuantityAndActiveToPizzas < ActiveRecord::Migration[8.0]
  def change
    add_column :pizzas, :quantity, :integer, default: 0
    add_column :pizzas, :active, :boolean, default: false
  end
end
