class AddQuantityAndActiveToSides < ActiveRecord::Migration[8.0]
  def change
    add_column :sides, :quantity, :integer,default: 0
    add_column :sides, :active, :boolean,default: false
  end
end
