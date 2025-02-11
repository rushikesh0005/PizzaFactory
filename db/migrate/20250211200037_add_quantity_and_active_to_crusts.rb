class AddQuantityAndActiveToCrusts < ActiveRecord::Migration[8.0]
  def change
    add_column :crusts, :quantity, :integer,default: 0
    add_column :crusts, :active, :boolean,default: false
  end
end
