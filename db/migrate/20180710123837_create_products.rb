class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :artist_name, :null => false
      t.string :product_name, :null => false, :index => true
      t.string :product_image_name_id, :null => false
      t.integer :price, :null => false
      t.integer :label_name, :null => false
      t.integer :genre_name, :null => false
      t.integer :inventry_status, :null => false
      t.integer :sales_quantity, :null => false, :default => 0
      t.integer :greed_id, :null => false, :index => true

      t.timestamps
    end
  end
end
