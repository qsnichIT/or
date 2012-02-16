class MaterialRoom < ActiveRecord::Base
  validates :room_id, :presence => {:message  => "กรุณาระบุห้อง" }
  validates :material_id, :presence => {:message  => "กรุณาระบุวัสดุ" }
  attr_accessible :material_id, :room_id, :amount, :user_id
  belongs_to :material
  has_one :unit, :through =>  :material
  belongs_to :room
end
