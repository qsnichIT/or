class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :admin
      t.string :room_id
      t.string :password_hash
      t.string :password_salt
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
