require 'test_helper'

class MaterialRoomsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => MaterialRoom.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    MaterialRoom.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    MaterialRoom.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to material_room_url(assigns(:material_room))
  end

  def test_edit
    get :edit, :id => MaterialRoom.first
    assert_template 'edit'
  end

  def test_update_invalid
    MaterialRoom.any_instance.stubs(:valid?).returns(false)
    put :update, :id => MaterialRoom.first
    assert_template 'edit'
  end

  def test_update_valid
    MaterialRoom.any_instance.stubs(:valid?).returns(true)
    put :update, :id => MaterialRoom.first
    assert_redirected_to material_room_url(assigns(:material_room))
  end

  def test_destroy
    material_room = MaterialRoom.first
    delete :destroy, :id => material_room
    assert_redirected_to material_rooms_url
    assert !MaterialRoom.exists?(material_room.id)
  end
end
