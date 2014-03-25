class Items < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.column :product_id, :int
      t.column :receipt_id, :int
      t.column :quantity, :int

      t.timestamp
    end
  end
end
