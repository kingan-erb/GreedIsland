class AddTotalPriceToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :total_price, :integer
    change_column_null :orders, :total_price, false
  end
end
