class Managers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.column :name, :string

      t.timestamp
    end
  end
end
