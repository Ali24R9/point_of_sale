class Cashiers < ActiveRecord::Migration
  def change
    create_table :cashiers do |t|
      t.column :name, :string

      t.timestamp
    end
  end
end
