class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.string :name
      t.string :status
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
