class DropAddress < ActiveRecord::Migration[5.2]
  def change
  	drop_table :addresses
  	drop_table :greeds
  end
end
