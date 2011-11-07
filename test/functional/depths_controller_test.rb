require 'test_helper'

class DepthsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:depths)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create depth" do
    assert_difference('Depth.count') do
      post :create, :depth => { }
    end

    assert_redirected_to depth_path(assigns(:depth))
  end

  test "should show depth" do
    get :show, :id => depths(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => depths(:one).to_param
    assert_response :success
  end

  test "should update depth" do
    put :update, :id => depths(:one).to_param, :depth => { }
    assert_redirected_to depth_path(assigns(:depth))
  end

  test "should destroy depth" do
    assert_difference('Depth.count', -1) do
      delete :destroy, :id => depths(:one).to_param
    end

    assert_redirected_to depths_path
  end
end
