class ChangeColumnToOrders < ActiveRecord::Migration[5.2]
  def change

		change_column_null :orders, :order_date, false
		change_column_null :orders, :payment_method, false
		change_column_null :orders, :delivery_date, false
      	change_column_null :orders, :delivery_time, false
      	change_column_null :orders, :delivery_address, false
      	change_column_null :orders, :delivery_status, false
      	change_column_null :orders, :user_id, false

      	change_column_null :cart_items, :user_id, false
		change_column_null :cart_items, :product_id, false
		change_column_null :cart_items, :quantity, false

  end



end
