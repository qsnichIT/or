require 'test_helper'

class MaterialRoomTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert MaterialRoom.new.valid?
  end
end
