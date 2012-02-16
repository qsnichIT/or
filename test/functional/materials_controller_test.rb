require 'test_helper'

class MaterialsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Material.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Material.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Material.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to material_url(assigns(:material))
  end

  def test_edit
    get :edit, :id => Material.first
    assert_template 'edit'
  end

  def test_update_invalid
    Material.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Material.first
    assert_template 'edit'
  end

  def test_update_valid
    Material.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Material.first
    assert_redirected_to material_url(assigns(:material))
  end

  def test_destroy
    material = Material.first
    delete :destroy, :id => material
    assert_redirected_to materials_url
    assert !Material.exists?(material.id)
  end
end
