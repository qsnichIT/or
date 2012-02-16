class Room < ActiveRecord::Base
  validates :name, :uniqueness => true
  attr_accessible :name, :status, :user_id
  has_many :material_rooms
  has_many :users
end
