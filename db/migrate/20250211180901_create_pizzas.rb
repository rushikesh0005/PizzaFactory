class CreatePizzas < ActiveRecord::Migration[8.0]
  def change
    create_table :pizzas do |t|
      t.string :name
      t.string :category
      t.decimal :price
      t.string :size

      t.timestamps
    end
  end
end
