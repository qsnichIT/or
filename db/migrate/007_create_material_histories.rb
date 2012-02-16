class CreateMaterialHistories < ActiveRecord::Migration
  def change
    create_table :material_histories do |t|
      t.integer :material_id
      t.integer :amount
      t.string :type
      t.string :hn
      t.integer :room_id
      t.integer :user_id

      t.timestamps
    end
  end
end
