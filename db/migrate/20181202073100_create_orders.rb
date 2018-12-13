class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id, :null => false
      t.string :address, :null => false
      t.integer :total_quantity, :null => false
      t.integer :total_price, :null => false
      t.boolean :deliverd, :null => false, :default => false

      t.timestamps
    end
    add_index :orders, :user_id
  end
end
