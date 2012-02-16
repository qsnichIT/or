class AddFlagToMaterialHistory < ActiveRecord::Migration
  def change
    add_column :material_histories, :flag, :string
  end
end
