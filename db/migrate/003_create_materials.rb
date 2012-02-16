class CreateMaterials < ActiveRecord::Migration
  def self.up
    create_table :materials do |t|
      t.string :material_code
      t.string :material_name
      t.string :claim
      t.integer :unit_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :materials
  end
end
