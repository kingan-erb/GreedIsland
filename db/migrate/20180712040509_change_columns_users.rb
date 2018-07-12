class ChangeColumnsUsers < ActiveRecord::Migration[5.2]
  def up
      change_column :users, :customer_status, :integer, default: 0, null: false, limit: 1
      change_column :users, :payment_method, :integer, default: 0, null: false, limit: 1

      remove_column :users, :postal_code, :integer
  end

  def down
  	  change_column :users, :customer_status, :integer
      change_column :users, :payment_method, :integer

      add_column :users, :postal_code, :integer
  end
end
