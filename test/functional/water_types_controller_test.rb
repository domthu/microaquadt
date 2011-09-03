require 'test_helper'

class WaterTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:water_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create water_type" do
    assert_difference('WaterType.count') do
      post :create, :water_type => { }
    end

    assert_redirected_to water_type_path(assigns(:water_type))
  end

  test "should show water_type" do
    get :show, :id => water_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => water_types(:one).to_param
    assert_response :success
  end

  test "should update water_type" do
    put :update, :id => water_types(:one).to_param, :water_type => { }
    assert_redirected_to water_type_path(assigns(:water_type))
  end

  test "should destroy water_type" do
    assert_difference('WaterType.count', -1) do
      delete :destroy, :id => water_types(:one).to_param
    end

    assert_redirected_to water_types_path
  end
end
