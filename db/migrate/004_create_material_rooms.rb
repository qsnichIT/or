class CreateMaterialRooms < ActiveRecord::Migration
  def self.up
    create_table :material_rooms do |t|
      t.integer :material_id
      t.integer :room_id
      t.integer :amount
      t.string :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :material_rooms
  end
end
