class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, :null => false
      t.integer :price, :null => false
      t.string :picture
      t.string :description, :limit => 200, :null => false
      t.integer :stock, :null => false

      t.timestamps
    end
    add_index :items, [:name, :description], :unique => true
  end
end
