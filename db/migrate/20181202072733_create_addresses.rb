class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :user, :null => false, :foreign_key => true
      t.string :address, :null => false

      t.timestamps
    end
    add_index :addresses, [:user_id, :address], :unique => true
  end
end
