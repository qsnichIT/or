class Material < ActiveRecord::Base
  validates :material_code, :uniqueness => {:message  => "รหัสวัสดุมีแล้วในระบบ" }
  #validates :unit_id, :uniqueness => {:message  => "กรุณาระบุหน่วยนับ" }
  attr_accessible :material_code, :material_name, :claim, :unit_id, :user_id
  belongs_to :unit
  has_many :material_rooms
end
