class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :quantity

      change_column :cart_items, :user_id, :integer, null: false
      change_column :cart_items, :product_id, :integer, null: false
      change_column :cart_items, :quantity, :integer, null: false

      t.timestamps

    end
  end
end
