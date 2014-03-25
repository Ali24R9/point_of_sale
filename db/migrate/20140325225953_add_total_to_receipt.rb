class AddTotalToReceipt < ActiveRecord::Migration
  def change
    add_column :receipts, :total, :decimal
  end
end
