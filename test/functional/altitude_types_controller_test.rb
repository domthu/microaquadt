require 'test_helper'

class AltitudeTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:altitude_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create altitude_type" do
    assert_difference('AltitudeType.count') do
      post :create, :altitude_type => { }
    end

    assert_redirected_to altitude_type_path(assigns(:altitude_type))
  end

  test "should show altitude_type" do
    get :show, :id => altitude_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => altitude_types(:one).to_param
    assert_response :success
  end

  test "should update altitude_type" do
    put :update, :id => altitude_types(:one).to_param, :altitude_type => { }
    assert_redirected_to altitude_type_path(assigns(:altitude_type))
  end

  test "should destroy altitude_type" do
    assert_difference('AltitudeType.count', -1) do
      delete :destroy, :id => altitude_types(:one).to_param
    end

    assert_redirected_to altitude_types_path
  end
end
