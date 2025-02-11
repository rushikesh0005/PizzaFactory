class CreateInventories < ActiveRecord::Migration[8.0]
  def change
    create_table :inventories do |t|
      t.string :item_type
      t.integer :item_id
      t.integer :stock

      t.timestamps
    end
  end
end
