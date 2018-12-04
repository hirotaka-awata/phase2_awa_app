class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, :null => false, :foreign_key => true
      t.integer :address, :null => false
      t.integer :total_quantity, :null => false
      t.integer :total_price, :null => false
      t.boolean :deliverd, :null => false, :default => false

      t.timestamps
    end
  end
end
