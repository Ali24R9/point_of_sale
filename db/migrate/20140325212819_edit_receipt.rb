class EditReceipt < ActiveRecord::Migration
  def change
    remove_column :receipts, :cashier_id
  end
end
