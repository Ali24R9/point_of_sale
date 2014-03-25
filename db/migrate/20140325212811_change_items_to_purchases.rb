class ChangeItemsToPurchases < ActiveRecord::Migration
  def change
    rename_table :items, :purchases
  end
end
