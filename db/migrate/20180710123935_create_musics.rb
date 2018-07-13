class CreateMusics < ActiveRecord::Migration[5.2]
  def change
    create_table :musics do |t|
      t.string :music_name, :null => false
      t.integer :music_number
      t.integer :disk_number, :null => false, :limit => 4
      t.integer :product_id, :null => false, :default => 0

      t.timestamps
    end
  end
end
