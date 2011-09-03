require 'test_helper'

class WaterUsesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:water_uses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create water_use" do
    assert_difference('WaterUse.count') do
      post :create, :water_use => { }
    end

    assert_redirected_to water_use_path(assigns(:water_use))
  end

  test "should show water_use" do
    get :show, :id => water_uses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => water_uses(:one).to_param
    assert_response :success
  end

  test "should update water_use" do
    put :update, :id => water_uses(:one).to_param, :water_use => { }
    assert_redirected_to water_use_path(assigns(:water_use))
  end

  test "should destroy water_use" do
    assert_difference('WaterUse.count', -1) do
      delete :destroy, :id => water_uses(:one).to_param
    end

    assert_redirected_to water_uses_path
  end
end
