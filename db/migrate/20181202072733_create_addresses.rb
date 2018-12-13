class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :user_id, :null => false
      t.string :address, :null => false

      t.timestamps
    end
    add_index :addresses, :user_id
  end
end
