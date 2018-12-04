class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.references :user, :null => false, :foreign_key => true
      t.references :item, :null => false, :foreign_key => true
      t.integer :item_price, :null => false
      t.integer :quantity, :null => false

      t.timestamps
    end
    add_index :cart_items, [:user_id, :item_id], :unique => true
  end
end
