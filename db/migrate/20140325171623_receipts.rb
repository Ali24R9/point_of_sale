class Receipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.column :cashier_id, :int

      t.timestamp
    end
  end
end
