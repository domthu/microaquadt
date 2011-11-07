require 'test_helper'

class SizeTypologiesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:size_typologies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create size_typology" do
    assert_difference('SizeTypology.count') do
      post :create, :size_typology => { }
    end

    assert_redirected_to size_typology_path(assigns(:size_typology))
  end

  test "should show size_typology" do
    get :show, :id => size_typologies(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => size_typologies(:one).to_param
    assert_response :success
  end

  test "should update size_typology" do
    put :update, :id => size_typologies(:one).to_param, :size_typology => { }
    assert_redirected_to size_typology_path(assigns(:size_typology))
  end

  test "should destroy size_typology" do
    assert_difference('SizeTypology.count', -1) do
      delete :destroy, :id => size_typologies(:one).to_param
    end

    assert_redirected_to size_typologies_path
  end
end
