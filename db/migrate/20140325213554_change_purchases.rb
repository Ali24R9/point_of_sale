class ChangePurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :cashier_id, :integer
  end
end
