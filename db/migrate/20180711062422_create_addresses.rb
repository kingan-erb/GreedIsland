class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :user_id, :null => false
      t.integer :postal_code, :null => false, :limit => 7
      t.string :address, :null => false

      t.timestamps
    end
  end
end
