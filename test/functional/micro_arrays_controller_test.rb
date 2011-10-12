require 'test_helper'

class MicroArraysControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:micro_arrays)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create micro_array" do
    assert_difference('MicroArray.count') do
      post :create, :micro_array => { }
    end

    assert_redirected_to micro_array_path(assigns(:micro_array))
  end

  test "should show micro_array" do
    get :show, :id => micro_arrays(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => micro_arrays(:one).to_param
    assert_response :success
  end

  test "should update micro_array" do
    put :update, :id => micro_arrays(:one).to_param, :micro_array => { }
    assert_redirected_to micro_array_path(assigns(:micro_array))
  end

  test "should destroy micro_array" do
    assert_difference('MicroArray.count', -1) do
      delete :destroy, :id => micro_arrays(:one).to_param
    end

    assert_redirected_to micro_arrays_path
  end
end
