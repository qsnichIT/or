class Unit < ActiveRecord::Base
  validates :name, :uniqueness => true
  attr_accessible :name, :status, :user_id
  has_many :materials
end
