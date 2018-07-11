class CreateGreeds < ActiveRecord::Migration[5.2]
  def change
    create_table :greeds do |t|
      t.string :greed_type, :null => false, :index => true

      t.timestamps
    end
  end
end
