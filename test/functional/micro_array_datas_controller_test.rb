require 'test_helper'

class MicroArrayDatasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:micro_array_datas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create micro_array_data" do
    assert_difference('MicroArrayData.count') do
      post :create, :micro_array_data => { }
    end

    assert_redirected_to micro_array_data_path(assigns(:micro_array_data))
  end

  test "should show micro_array_data" do
    get :show, :id => micro_array_datas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => micro_array_datas(:one).to_param
    assert_response :success
  end

  test "should update micro_array_data" do
    put :update, :id => micro_array_datas(:one).to_param, :micro_array_data => { }
    assert_redirected_to micro_array_data_path(assigns(:micro_array_data))
  end

  test "should destroy micro_array_data" do
    assert_difference('MicroArrayData.count', -1) do
      delete :destroy, :id => micro_array_datas(:one).to_param
    end

    assert_redirected_to micro_array_datas_path
  end
end
