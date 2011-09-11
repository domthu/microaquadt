require 'test_helper'

class MeteorologicalDatasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meteorological_datas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meteorological_data" do
    assert_difference('MeteorologicalData.count') do
      post :create, :meteorological_data => { }
    end

    assert_redirected_to meteorological_data_path(assigns(:meteorological_data))
  end

  test "should show meteorological_data" do
    get :show, :id => meteorological_datas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => meteorological_datas(:one).to_param
    assert_response :success
  end

  test "should update meteorological_data" do
    put :update, :id => meteorological_datas(:one).to_param, :meteorological_data => { }
    assert_redirected_to meteorological_data_path(assigns(:meteorological_data))
  end

  test "should destroy meteorological_data" do
    assert_difference('MeteorologicalData.count', -1) do
      delete :destroy, :id => meteorological_datas(:one).to_param
    end

    assert_redirected_to meteorological_datas_path
  end
end
