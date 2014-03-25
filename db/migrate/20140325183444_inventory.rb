class Inventory < ActiveRecord::Migration
  def change
    create_table :inventory do |t|
      t.column :product_id, :int
      t.column :quantity, :int

      t.timestamp
    end
  end
end
