require 'test_helper'

class LandUseMappingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:land_use_mappings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create land_use_mapping" do
    assert_difference('LandUseMapping.count') do
      post :create, :land_use_mapping => { }
    end

    assert_redirected_to land_use_mapping_path(assigns(:land_use_mapping))
  end

  test "should show land_use_mapping" do
    get :show, :id => land_use_mappings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => land_use_mappings(:one).to_param
    assert_response :success
  end

  test "should update land_use_mapping" do
    put :update, :id => land_use_mappings(:one).to_param, :land_use_mapping => { }
    assert_redirected_to land_use_mapping_path(assigns(:land_use_mapping))
  end

  test "should destroy land_use_mapping" do
    assert_difference('LandUseMapping.count', -1) do
      delete :destroy, :id => land_use_mappings(:one).to_param
    end

    assert_redirected_to land_use_mappings_path
  end
end
