class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :order_id, :null => false
      t.integer :product_id, :null => false
      t.string :o_artist_name, :null => false
      t.string :o_product_name, :null => false, :index => true
      t.string :o_product_image_name_id, :null => false
      t.integer :o_price, :null => false
      t.integer :o_greed_id, :null => false, :index => true
      t.integer :o_quantity, :null => false

      t.timestamps
    end
  end
end
