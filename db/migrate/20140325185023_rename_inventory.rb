class RenameInventory < ActiveRecord::Migration
  def change
    rename_table :inventory, :quantities
  end
end
