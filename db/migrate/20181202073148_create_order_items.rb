class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :order_id, :null => false
      t.integer :item_id, :null => false
      t.integer :item_price, :null => false
      t.integer :item_quantity, :null => false

      t.timestamps
    end
    add_index :order_items, [:order_id, :item_id], :unique => true
  end
end
