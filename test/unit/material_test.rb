require 'test_helper'

class MaterialTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Material.new.valid?
  end
end
