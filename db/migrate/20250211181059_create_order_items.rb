class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :pizza, null: false, foreign_key: true
      t.references :crust, null: false, foreign_key: true
      t.references :side, null: false, foreign_key: true

      t.timestamps
    end
  end
end
