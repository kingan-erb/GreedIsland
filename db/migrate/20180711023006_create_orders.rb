class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.datetime :order_datetime
      t.integer :payment_method
      t.date :delivery_date
      t.integer :delivery_time
      t.integer :postal_code
      t.string :delivery_address
      t.integer :delivery_status
      t.integer :user_id
      t.integer :total_price

      t.timestamps
    end
  end
end
